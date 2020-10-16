import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Receita{
  int id,tempo,nIngredientes;
  String titulo,tipo;
  List ingredientes,preparo;
  AssetImage image;
  Receita({this.id,this.titulo,this.tipo,this.tempo,this.nIngredientes,this.ingredientes,this.image,this.preparo});

}
var receitaController = ReceitaController();

class ReceitaController{
  var _nextid = 1;
  var _receitas = <Receita>[];

  List<Receita> getAll(){
    //print(_receitas);
    return _receitas;
  }
  List getByTipo(String tipo){
    List temp;
    for(Receita p in _receitas){
      if (p.tipo == tipo){
        temp.add(p);
      }
      return temp;
    }
  }
  getById(int id){
    List temp;
    for(Receita p in _receitas){
      if (p.id == id){
        temp.add(p);
      }
      return temp;
    }
  }
  void save(receita){
    if (receita.id == null){
      receita.id = _nextid++;
      _receitas.add(receita);
    }
    return receita;
  }
}