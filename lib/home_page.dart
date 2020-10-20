import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projeto_3/widgets.dart';
import 'package:projeto_3/assets_handler.dart';
import 'package:http/http.dart' as http;

import 'Receitas.dart';
import 'http service.dart';

class HomePage extends StatelessWidget {
  bool isLoading = true;

  _fetchData() async {
    if (pathControler.getPath() == null){

    }
    else{
    final response =
    await http.get("${pathControler.getPath()}get_recommended");
    return mapData(response.body.toString());
    }
  }

  mapData(String jsonString) {
    recomendadoController.clear();
    Map<String, dynamic> jsonmap = jsonDecode(jsonString);
    jsonmap['recommended']
        .map<Receita>((json) => Receita.fromJson(json))
        .toList()
        .forEach((receita) => recomendadoController.save(receita));
  }

  @override
  Widget build(BuildContext context) {
    _fetchData();
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Assets.whiteColor,
        body: Column(
          children: [
            Hero(
              tag: 'intelibar',
              child: Material(
                color: Colors.transparent,
                child: InteliBar(
                  color: Assets.blueColor,
                  leftIcon: Icons.menu,
                  rightIcon: Icons.more_vert,
                  rightPath: '/settings',
                ),
              ),
            ),
            Assets.smallPaddingBox,
            Hero(
                tag: 'searchbar',
                child: Material(
                  color: Colors.transparent,
                  child:
                    SearchBar(
                      colorIcon:Assets.whiteColor,
                      colorMain: Assets.darkGreyColor,
                      path: '/food_display',
                      action: 'modal',
                      isForm: false
                    ),
                )
            ),
            
            Assets.smallPaddingBox,
            Row(
              children: [
                Assets.smallPaddingBox,
                TextBar(
                  texto: "Categorias",
                  theme: 'dark',
                  size: 15,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4,left: 8,right: 8,bottom: 8),
              child: ColectionBar(),
            ),//ColectionBar
            RecommendedDisplay(),
          ],
        ),
      ),
    );
  }
}
