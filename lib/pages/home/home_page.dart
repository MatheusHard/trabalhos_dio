import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trabalhos_dio/pages/shared/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TRABALHOS DIO")),
      body: Container(
    margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),

      ),
      drawer: const DrawerCustom(),
      );

  }
}
