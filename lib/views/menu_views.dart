import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MenuViews extends StatefulWidget {
  const MenuViews({Key? key}) : super(key: key);

  @override
  _MenuViewsState createState() => _MenuViewsState();
}

class _MenuViewsState extends State<MenuViews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Servicios UTPL - Cine foro y Noticias'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/foto1.jpg'), // Ruta de la imagen de fondo
            fit: BoxFit.cover, // Ajustar la imagen para que cubra todo el fondo
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 8, // Añadir elevación al bottomNavigationBar
        shape: CircularNotchedRectangle(), // Dar forma circular
        notchMargin: 8, // Ajustar el espacio entre el contenido y el notch
        child: Container(
          height: 80, // Ajustar la altura del bottomNavigationBar
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: IconButton(
                      icon: Icon(Icons.article_outlined,
                          size: 36), // Ajustar el tamaño del ícono
                      onPressed: () {
                        Navigator.pushNamed(context, '/listadoNoticias');
                      },
                    ),
                  ),
                  Text(
                    'Noticias',
                    style:
                        TextStyle(fontSize: 16), // Ajustar el tamaño del texto
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: IconButton(
                      icon: Icon(Icons.movie_outlined,
                          size: 36), // Ajustar el tamaño del ícono
                      onPressed: () {
                        Navigator.pushNamed(context, '/cineforo');
                      },
                    ),
                  ),
                  Text(
                    'Cine Foro',
                    style:
                        TextStyle(fontSize: 16), // Ajustar el tamaño del texto
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
