import 'package:http/http.dart' as http;
import 'dart:convert';
import '/models/event_detail_model.dart';
import '/models/event_list_model.dart';

class EventDetailService {
  final String apiUrl =
      'https://appmovil.utpl.edu.ec:8080/v2/library/benjamin/cine/forum/show/';
  Future<EventDetaillModel> fetchEventDetail(String id) async {
    try {
      final response = await http.get(Uri.parse(apiUrl + id));
      if (response.statusCode == 200) {
        final eventDetailModel =
            EventDetaillModel.fromJson(json.decode(response.body));
        return eventDetailModel;
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

class EventListService {
  final String apiUrl =
      'https://appmovil.utpl.edu.ec:8080/v2/library/benjamin/cine/forum/all?page=1';
  List<Datum> movies = [];
  Future<List<Datum>> fetchEventList() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final eventListModel =
            EventListModel.fromJson(json.decode(response.body));
        movies = eventListModel.data;
        return movies;
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
