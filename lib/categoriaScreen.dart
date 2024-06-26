import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mercado/addCategoriaScreen.dart';
import 'package:mercado/modelCategoria.dart';
import 'package:mercado/produtoScreen.dart';
import 'package:mercado/sharedPreferencesHelper.dart';

class CategoriaScreen extends StatefulWidget {
  @override
  _CategoriaScreenState createState() => _CategoriaScreenState();
}

class _CategoriaScreenState extends State<CategoriaScreen> {
  final SharedPreferencesHelper _prefsHelper = SharedPreferencesHelper();
  List<Categoria> _categorias = [];

  @override
  void initState() {
    super.initState();
    _refreshCategorias();
  }

  Future<void> _refreshCategorias() async {
    final categorias = await _prefsHelper.getCategorias();
    setState(() {
      _categorias = categorias;
    });
  }

  void _addCategoria() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddCategoriaScreen(onSave: _refreshCategorias),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 227, 227, 227),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 227, 227, 227),
        title: Text('Todas as Categorias'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: (_categorias.length / 2).ceil(),
        itemBuilder: (context, index) {
          final int firstIndex = index * 2;
          final int secondIndex = firstIndex + 1;
          return Row(
            children: <Widget>[
              SizedBox(width: 20),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProdutoScreen(
                          categoriaNome: _categorias[firstIndex].nome,
                          categoriaId: _categorias[firstIndex].id,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    color: Color.fromARGB(255, 255, 255, 255),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: _categorias[firstIndex].imagem.isNotEmpty
                                ? Image.file(File(_categorias[firstIndex].imagem))
                                : SizedBox(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(_categorias[firstIndex].nome),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              secondIndex < _categorias.length
                  ? Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProdutoScreen(
                                categoriaNome: _categorias[secondIndex].nome,
                                categoriaId: _categorias[secondIndex].id,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: _categorias[secondIndex].imagem.isNotEmpty
                                      ? Image.file(File(_categorias[secondIndex].imagem))
                                      : SizedBox(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(_categorias[secondIndex].nome),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Expanded(child: SizedBox()),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCategoria,
        tooltip: 'Adicionar Categoria',
        child: Icon(Icons.add),
      ),
    );
  }
}
