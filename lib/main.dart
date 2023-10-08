import 'package:flutter/material.dart';
import 'package:trabalhos_dio/pages/home_page.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();


  runApp(
      MaterialApp(
        title: 'DIO',
        debugShowCheckedModeBanner: false,
        routes: {
          '/home_page': (BuildContext context) => const HomePage(),

        },
        initialRoute: '/home_page',
      ));
}
