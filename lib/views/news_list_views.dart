import 'package:flutter/material.dart';

import '/services/news_service.dart';
import '/models/new_list_model.dart';

import '/views/news_detail_views.dart';

class NewsListViews extends StatefulWidget {
  const NewsListViews({Key? key}) : super(key: key);
  @override
  NewsListViewsState createState() => NewsListViewsState();
}

class NewsListViewsState extends State<NewsListViews> {
  final NewsListService noticiasService = NewsListService();
  final ScrollController _scrollController = ScrollController();
  final List<Datum> _noticias = [];
  int _currentPage = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadNoticias();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadNoticias() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final nuevasNoticias =
          await noticiasService.fetchNewsList(page: _currentPage);
      setState(() {
        _noticias.addAll(nuevasNoticias);
      });
    } catch (e) {
      //manejo de errores
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onScroll() {
    if (_scrollController.position.atEdge &&
        _scrollController.position.pixels != 0) {
      setState(() {
        _currentPage++;
      });
      _loadNoticias();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _noticias.length * 2 + 1,
        itemBuilder: (context, index) {
          if (index.isOdd) {
            return Divider(
              color: Colors.grey[400],
              thickness: 1,
            );
          }

          final noticiaIndex = index ~/ 2;
          if (noticiaIndex < _noticias.length) {
            final noticia = _noticias[noticiaIndex];
            return ListTile(
              title: Text(noticia.title),
              leading: FadeInImage(
                placeholder: const AssetImage('/assets/loading-cargando.gif'),
                image: NetworkImage(noticia.image.url),
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 20),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsDetailViews(id: noticia.id),
                  ),
                );
              },
            );
          } else {
            return _isLoading
                ? _buildLoadingIndicator()
                : const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}
