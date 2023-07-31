import 'package:flutter/material.dart';

import '/models/event_detail_model.dart';
import '/services/event_service.dart';

class EventDetalleViews extends StatelessWidget {
  final String id;

  const EventDetalleViews({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<EventDetaillModel>(
      future: EventDetailService().fetchEventDetail(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: const Text('Cargando...')),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(child: Text('Error al cargar los detalles')),
          );
        } else {
          final pelicula = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                pelicula.data.title,
                style: const TextStyle(
                  fontSize: 13.5,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(pelicula.data.image.url),
                      const SizedBox(height: 16),
                      Text(
                        pelicula.data.title,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1.5,
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: pelicula.data.description.split(' ')[0],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: pelicula.data.description.substring(
                                pelicula.data.description.split(' ')[0].length),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: pelicula.data.attrs.length,
                    itemBuilder: (context, index) {
                      final attr = pelicula.data.attrs[index];
                      return ListTile(
                        title: Text('${attr.name}:',
                            style: const TextStyle(fontSize: 18)),
                        subtitle: Text(attr.value,
                            style: const TextStyle(fontSize: 18)),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Colors.grey,
                        thickness: 1.5,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
