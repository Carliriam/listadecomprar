import 'package:flutter/material.dart';
import 'package:listadecompras/categoriacreen.dart';
import 'dart:async';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _introScreen(),
    );
  }

  Widget _introScreen() {
    return SplashScreen(
      seconds: 5,
      gradientBackground: LinearGradient(
        colors: [Colors.red, Colors.orange],
      ),
      loaderColor: Colors.white,
      image: Image.asset('assets/logo.png'),
      photoSize: 100.0,
      navigateAfterSeconds: ListaComprasScreen(),
    );
  }
}

class ListaComprasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Aqui você pode criar a tela da lista de compras
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Compras')),
      body: Center(
        child: Text('Itens da sua lista de compras'),
      ),
    );
  }
}
