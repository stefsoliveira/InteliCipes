import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_3/widgets.dart';
import 'package:projeto_3/Receitas.dart';
import 'package:projeto_3/assets_handler.dart';
import 'package:projeto_3/infra.dart';

class FoodDisplay extends StatefulWidget {
  final items;

  const FoodDisplay({Key key, this.items}) : super(key: key);
  @override
  FoodDisplayPage createState() {
    return FoodDisplayPage();
  }
}
class FoodDisplayPage extends State<FoodDisplay>{
  final _items = receitaController.getAll();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Assets.whiteColor,
      body: Column(
        children: [
          Container(
            height: Helper.getScreenHeight(context),
            decoration: BoxDecoration(
                //borderRadius: BorderRadius.vertical(top:Radius.circular(40)),
                color: Assets.darkGreyColor,
            ),
            child: Column(
              children: [
                SizedBox(height: 20,),
                Container(
                  height: 5,
                  width: Helper.getScreenWidth(context)/1.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Assets.whiteColor),
                ),
                SizedBox(height: 10,),
                GestureDetector( // Deslizar para baixo para voltar a tela
                  onVerticalDragUpdate: (details) {
                    if(details.delta.dy > 2){
                      Helper.back(context);
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
                  height: Helper.getScreenHeight(context)-85, // se der problema de overflow incremente esse numero
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.all(0),
                    itemCount: _items.length,
                    itemBuilder: _buildListTile,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildListTile(context,index){
    var __receita = _items;
    var _receita = __receita[index];
    return ListTile(
        visualDensity: VisualDensity.compact,
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.7),
                offset: Offset(0,3),
                blurRadius: 5
              )
            ]
          ),
          child: ReceitaDisplay(
            titulo:_receita.titulo,
            ingredientes:_receita.ingredientes,
            tempo:_receita.tempo,
            image: _receita.image,
            height_main: 230,
            iconColor: Assets.blueColor,
          )
        ),
      );
    }
}