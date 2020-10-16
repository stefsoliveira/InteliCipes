import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Receita {
  var id, index, tempo, nIngredientes;
  var titulo, tipo;
  var ingredientes, preparo;
  AssetImage image;

  Receita(
      {this.index,
      this.id,
      this.titulo,
      this.tipo,
      this.tempo,
      this.nIngredientes,
      this.ingredientes,
      this.image,
      this.preparo});

  factory Receita.fromJson(Map<String, dynamic> json) {
    return Receita(
        tempo: json['minutes'],
        nIngredientes: json['n_ingredients'],
        titulo: json['name'],
        index: json['id']);
  }
}

var receitaController = ReceitaController();
var recomendadoController = ReceitaController();
var pesquisaController = ReceitaController();

class ReceitaController {
  var _nextid = 1;
  var _receitas = <Receita>[];

  List<Receita> getAll() {
    //print(_receitas);
    return _receitas;
  }

  List getByTipo(String tipo) {
    List temp;
    for (Receita p in _receitas) {
      if (p.tipo == tipo) {
        temp.add(p);
      }
      return temp;
    }
  }

  getById(int id) {
    List temp;
    for (Receita p in _receitas) {
      if (p.id == id) {
        temp.add(p);
      }
      return temp;
    }
  }

  void save(receita) {
    if (receita.id == null) {
      receita.id = _nextid++;
      _receitas.add(receita);
    }
    return receita;
  }
  void clear(){
    _receitas = [];
  }
}
