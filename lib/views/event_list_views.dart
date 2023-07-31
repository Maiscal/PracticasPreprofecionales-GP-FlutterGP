import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'links_views.dart';

class EventListViews extends StatefulWidget {
  const EventListViews({Key? key}) : super(key: key);
  @override
  EventListState createState() => EventListState();
}

class EventListState extends State<EventListViews> {
  final EventListService cineService = EventListService();
  final CarouselController _sliderController = CarouselController();

  void _onMovieTap(String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventDetalleViews(
          id: id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cine Foro'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/palomitas.jpg'), //cambiarlo
            fit: BoxFit.fill,
          ),
        ),
        child: FutureBuilder<List<Datum>>(
          future: cineService.fetchEventList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final peliculas = snapshot.data!;
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Número de columnas por fila
                  crossAxisSpacing: 16, // Espacio horizontal entre las columnas
                  mainAxisSpacing: 16, // Espacio vertical entre las filas
                ),
                itemCount: peliculas.length,
                itemBuilder: (context, index) {
                  final pelicula = peliculas[index];
                  return GestureDetector(
                    onTap: () => _onMovieTap(pelicula.id),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AspectRatio(
                            aspectRatio: 543 / 411,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                pelicula.image.url,
                                width: 25, // Ajustar el ancho deseado
                                height: 25, // Ajustar la altura deseada
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            pelicula.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
