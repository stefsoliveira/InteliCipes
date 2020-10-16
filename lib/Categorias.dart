import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Categorias {
  int id;
  String titulo;
  AssetImage image;

  Categorias({this.titulo, this.image});

  factory Categorias.fromJson(Map<String,dynamic> json){
    return Categorias(
      titulo: json['titulo'],
      image: json['image']
    );
  }

}

var categoriaControler = CategoriaControler();

class CategoriaControler {
  int id = 1;
  var _listCategorias = <Categorias>[];

  List<Categorias> getall() {
    return _listCategorias;
  }

  save(categoria) {
    if (categoria.id == null) {
      categoria.id = id++;
      _listCategorias.add(categoria);
    }
    return categoria;
  }
}
