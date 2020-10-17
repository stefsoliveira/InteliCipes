import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

class RecipesPage extends StatelessWidget {
  @override
  Widget build(BuildContext Context) {
    return Scaffold(
      backgroundColor: Assets.whiteColor,
      body: Column(
        children: [
          Container(
            height: Helper.getScreenHeight(Context),
            decoration: BoxDecoration(
              //borderRadius: BorderRadius.vertical(top:Radius.circular(40)),
              color: Assets.darkGreyColor,
            ),
            child: Column(
              children: [
                SizedBox(height: 20,),
                Container(
                  height: 5,
                  width: Helper.getScreenWidth(Context)/1.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Assets.whiteColor),
                ),
                SizedBox(height: 10,),
                GestureDetector( // Deslizar para baixo para voltar a tela
                  onVerticalDragUpdate: (details) {
                    if(details.delta.dy > 2){
                      Helper.back(Context);
                    }
                  },
                  child: Hero( // animaçao entre as telas
                      tag:'searchbar',
                      child:Material(
                        color: Colors.transparent,
                        child: SearchBar(colorMain:Assets.whiteColor,colorIcon:Assets.blackColorPlaceholder,barSize: 50,),
                      )),
                ),
                Assets.smallPaddingBox,
                Container(
                  height: Helper.getScreenHeight(Context)-85, // se der problema de overflow incremente esse numero
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}