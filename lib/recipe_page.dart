import 'package:flutter/material.dart';
import 'package:projeto_3/widgets.dart';

import 'assets_handler.dart';


class RecipePage extends StatelessWidget {
  String titulo;
  String ingredientes;
  String preparo;
  String tempo;
  AssetImage image = Assets.Placeholder1;

  RecipePage({
    this.titulo = 'Frango ao forno',
    this.ingredientes = 'Ingredientes: frango, arroz, lentilha ,creme de leite',
    this.preparo = 'Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ui officia deserunt mollit anim id est laborum consectetur adipiscing dolore magna aliq',
    this.tempo = "10min",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Assets.whiteColor,
        body: Column(
            children: [
              Hero(
                tag: 'transparentbar',
                child: Material(
                  color: Colors.transparent,
                  child: InteliBar(
                    color: Colors.transparent,
                    leftIcon: Icons.arrow_back,
                    leftPath: '/food_display',
                    rightIcon: Icons.favorite_border,
                  ),
                ),
              ),
              Hero(
                tag: 'imagem da receita',
                child: setImage(image),
              ),
              Column(
                children: <Widget>[
                  _getBody(titulo, tempo, preparo, ingredientes)
                  ]
              ),
              ],
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
          fontSize: 30.0),
    );
  }

  _getTime(tempo) {
    return new Container(
        margin: new EdgeInsets.only(top: 5.0),
        child: new Text(tempo,
          style: new TextStyle(
              fontSize: 15.0,
          ),
        )
    );
  }

  _getIngredients(ingredientes) {
    return new Container(
      margin: new EdgeInsets.only(top: 20.0),
      child: new Text(ingredientes),
    );
  }
  _getPreparation(preparo) {
    return new Container(
      margin: new EdgeInsets.only(top: 20.0),
      child: new Text(preparo),
    );
  }
}

setImage(image) {
  if (image == null) {
    return Container(
      color: Assets.blueColor,
      height: 80,
      width: 80,
    );
  } else {
    return Image.asset(
      image.assetName,
      scale: 1,
      height: 230,
    );
  }
}