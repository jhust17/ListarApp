import 'package:flutter/material.dart';
import 'package:tallerapp/pages/listar.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: inicio());
  }
}

class inicio extends StatefulWidget {
  const inicio({super.key});

  @override
  State<inicio> createState() => _inicioState();
}

class _inicioState extends State<inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aplicacion Listar Datos"),
      ),
      body: Center(
        child: Center(
            child: SizedBox(
          width: 100,
          height: 80,
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Pagel())
                );
              },
              child: Text(
                "Listar",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
        )),
      ),
    );
  }
}
