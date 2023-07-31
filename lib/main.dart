import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'views/links_views.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.blue[900]),
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
      ),
      home: const MenuViews(),
      getPages: [
        GetPage(
          name: '/home',
          page: () => const MenuViews(),
          transition: Transition.native,
        ),
        GetPage(
          name: '/listadoNoticias',
          page: () => const NewsListViews(),
          transition: Transition.native,
        ),
        GetPage(
          name: '/cineforo',
          page: () => const EventListViews(),
          transition: Transition.native,
        ),
      ],
    );
  }
}
