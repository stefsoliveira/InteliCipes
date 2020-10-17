import 'package:flutter/material.dart';

import 'assets_handler.dart';


class RecipePage extends StatelessWidget {
  String titulo;
  String ingredientes;
  String preparo;
  String tempo;


  RecipePage({
    this.titulo = 'none',
    this.ingredientes = "[1,2,3,4]",
    this.preparo = "[1,2,3,4]",
    this.tempo = "10",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Assets.darkGreyColor,
        body:Expanded(
          child: Container(
            margin: new EdgeInsets.all(10.0),
            child: new Material(
              elevation: 4.0,
              borderRadius: new BorderRadius.circular(6.0),
              child: new ListView(
                children: <Widget>[
                  _getBody(titulo, tempo, preparo, ingredientes),
                ],
          ),
        ),
      ),
    ),
    );

  }

  Widget _getBody(titulo, tempo, preparo, ingredientes) {
    return new Container(
      margin: new EdgeInsets.all(15.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getTitle(titulo),
          _getTime(tempo),
          _getPreparation(preparo),
          _getIngredients(ingredientes),
        ],
      ),
    );
  }

  _getTitle(titulo) {
    return new Text(titulo,
      style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0),
    );
  }

  _getTime(tempo) {
    return new Container(
        margin: new EdgeInsets.only(top: 5.0),
        child: new Text(tempo,
          style: new TextStyle(
              fontSize: 10.0,
              color: Colors.grey
          ),
        )
    );
  }

  _getPreparation(preparo) {
    return new Container(
      margin: new EdgeInsets.only(top: 20.0),
      child: new Text(preparo),
    );
  }

  _getIngredients(ingredientes) {
    return new Container(
      margin: new EdgeInsets.only(top: 20.0),
      child: new Text(ingredientes),
    );
  }

}