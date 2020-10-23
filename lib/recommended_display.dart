import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_3/widgets.dart';
import 'package:projeto_3/Receitas.dart';
import 'package:projeto_3/assets_handler.dart';
import 'package:projeto_3/infra.dart';
import 'package:http/http.dart' as http;

import 'http service.dart';

class _ItemFetcher {
  int _pageCount = 0;

  Future<List>fetch(grupo,cluster) async {
    print('fetch');
    List _items = [];
    pesquisaController.clear();
    final response =
    await http.get("${pathControler.getPath()}/next/$grupo/$cluster/$_pageCount");
    Map<String, dynamic> jsonmap = jsonDecode(response.body.toString());
    if (jsonmap['pesquisa'] == []){
      return _items;
    }
    jsonmap['pesquisa']
        .map<Receita>((json) => Receita.fromJson(json))
        .toList()
        .forEach((receita) => _items.add(receita));
    _pageCount ++;
    return _items;
  }
}

class FoodDisplay extends StatefulWidget {
  final argument;
  const FoodDisplay({Key key,this.argument}) : super(key: key);
  @override
  FoodDisplayPage createState() {
    return FoodDisplayPage();
  }
}
class FoodDisplayPage extends State<FoodDisplay>{
  List items = [];
  var _itemFetcher = _ItemFetcher();
  var grupo;
  bool _isLoading = true;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _hasMore = true;
    _loadMore();
    print('init');
  }

  void _loadMore() {
    print("loadmore");
    var grupoIndex = widget.argument; /// [0] index [1] cluster
    _isLoading = true;
    _itemFetcher.fetch(grupoIndex[1],grupoIndex[0]).then((List fetchedList) {
      if (fetchedList.isEmpty) {
        setState(() {
          _isLoading = false;
          _hasMore = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          items.addAll(fetchedList);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    grupo = Helper.getRouteArgs(context);
    int lenPlus = items.length + 1;
    print('this $lenPlus');
    int len = items.length;
    print(grupo);
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
                  onTap: () => Helper.back(context),
                  onVerticalDragUpdate: (details) {
                    if(details.delta.dy > 2){
                      Helper.back(context);
                    }
                  },
                  child: Hero( // animaçao entre as telas
                    tag:'searchbar',
                      child:Material(
                        color: Colors.transparent,
                        child: TextBar(
                          texto: 'Voltar',
                          theme: 'light',
                          padding: 2,
                          size: 15,
                        ),
                      )),
                ),
                Assets.smallPaddingBox,
                Container(
                  height: Helper.getScreenHeight(context)-85, // se der problema de overflow incremente esse numero
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.all(0),
                    itemCount: _hasMore ? lenPlus : len,
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
    if (index >= items.length) {
      if(!_isLoading){
        _loadMore();
      }
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Assets.whiteColor),
          strokeWidth: 2,
        ),
      );
    }
    Receita _items = items[index];
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
              titulo:_items.titulo,
              ingredientes:_items.ingredientes,
              tempo:_items.tempo,
              image: _items.image,
              preparo: _items.preparo,
              height_main: 230,
              iconColor: Assets.blueColor,
              group: _items.tipo,
            )
        ),
      );
    }
    }
