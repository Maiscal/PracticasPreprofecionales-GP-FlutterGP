import 'package:http/http.dart' as http;
import 'dart:convert';
import '/models/new_detail_model.dart';
import '/models/new_list_model.dart';

class NewsDetailService {
  final String apiUrl = 'https://appmovil.utpl.edu.ec:8080/v1/news/show/';
  Future<NewsDetailModel> fetchNewDetails(String id) async {
    try {
      final response = await http.get(Uri.parse(apiUrl + id));
      if (response.statusCode == 200) {
        final noticiasDetalleModel =
            NewsDetailModel.fromJson(json.decode(response.body));
        return noticiasDetalleModel;
      } else {
        print('Error: ${response.statusCode}');
        throw Exception('Error en la solicitud HTTP');
      }
    } catch (e) {
      print('Error de conexión: $e');
      throw Exception('Error de conexión');
    }
  }
}

class NewsListService {
  final String apiUrl = 'https://appmovil.utpl.edu.ec:8080/v1/news/all';
  Future<List<Datum>> fetchNewsList({int page = 1}) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl?page=$page'));
      if (response.statusCode == 200) {
        final newsListModel = NewListModel.fromJson(json.decode(response.body));
        return newsListModel.data;
      } else {
        print('Error: ${response.statusCode}');
        throw Exception('Error en la solicitud HTTP');
      }
    } catch (e) {
      print('Error de conexión: $e');
      throw Exception('Error de conexión');
    }
  }
}
