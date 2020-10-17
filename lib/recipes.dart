import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_3/assets_handler.dart';
import 'package:projeto_3/infra.dart';
import 'package:projeto_3/recipe_page.dart';
import 'package:projeto_3/widgets.dart';
import 'assets_handler.dart';
import 'infra.dart';

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
  
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    this._context = context;
    return new Container(
      margin: const EdgeInsets.only(
          left: 10.0, right: 10.0, bottom: 10.0, top: 0.0),
      child: new Material(
        borderRadius: new BorderRadius.circular(6.0),
        elevation: 2.0,
        child: new InkWell(
          onTap: showRecipePage,
          splashColor: Colors.blue,
          child: _getListTile(),
        ),
      ),
    );
  }

  Widget _getListTile() {
    // Foi adicionado dentro de Container para adicionar altura fixa.
    return new Container(
      height: 95.0,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getColumText(titulo, tempo, preparo, ingredientes),
        ],
      ),
    );
  }

  Widget _getColumText(titulo, tempo, preparo, ingredientes) {
    return new Expanded(
        child: new Container(
          margin: new EdgeInsets.all(10.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _getTitleWidget(titulo),
              _getTimeWidget(tempo),
              _getPreparationWidget(preparo),
              _getIngredientsWidget(ingredientes)
            ],
          ),
        ));
  }

  Widget _getTitleWidget(String titulo) {
    return new Text(
      titulo,
      maxLines: 1,
      style: new TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _getPreparationWidget(preparo) {
    return new Container(
      margin: new EdgeInsets.only(top: 5.0),
      child: new Text(
        preparo,
        maxLines: 2,
      ),
    );
  }

  Widget _getTimeWidget(String tempo) {
    return new Text(
      tempo,
      style: new TextStyle(color: Colors.grey, fontSize: 10.0),
    );
  }

  Widget _getIngredientsWidget(List ingredientes) {
    return new Text(
      tempo,
      style: new TextStyle(color: Colors.grey, fontSize: 10.0),
    );
  }

  showRecipePage() {
    Navigator
        .of(_context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return new RecipePage(titulo, tempo, preparo, ingredientes);
    }));
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

  void clear() {
    _receitas = [];
  }
}



