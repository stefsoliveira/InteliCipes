import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projeto_3/Receitas.dart';
import 'package:projeto_3/assets_handler.dart';
import 'package:projeto_3/blocs/theme.dart';
import 'package:projeto_3/widgets.dart';
import 'package:provider/provider.dart';
import 'package:projeto_3/infra.dart';

import 'package:http/http.dart' as http;

import 'http service.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  bool isLoading = false;
  var texto = '';
  var list;
  var formkey = GlobalKey<FormState>();

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response =
    await http.get("${pathControler.getPath()}get_recommended");

    setState(() {
      isLoading = false;
    });
    texto = response.body.toString();
    return mapData(response.body.toString());
  }

  mapData(String jsonString) {
    Map<String, dynamic> jsonmap = jsonDecode(jsonString);
    jsonmap['recommended']
        .map<Receita>((json) => Receita.fromJson(json))
        .toList()
        .forEach((receita) => receitaController.save(receita));
    Receita a = receitaController.getAll()[1];
    print([
      a.titulo,
      a.tempo,
      a.image,
      a.nIngredientes,
      a.index,
      a.preparo,
      a.tipo
    ]);
  }

  void saveData(text) {
    pathControler.save(text);
    print(pathControler.getPath());
  }

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);

    return Scaffold(
      backgroundColor: Assets.darkGreyColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RaisedButton(
          child: new Text("Fetch Data"),
          onPressed: _fetchData,
        ),
      ),
      body: Column(
        children: [
          Hero(
            tag: 'intelibar',
            child: Material(
              color: Colors.transparent,
              child: InteliBar(
                title: Text("Settings",
                  style: InriaSansStyle(
                      size: 25,
                      color: Assets.whiteColor,
                      shadow: [
                        Shadow(
                            offset: Offset(0, 2),
                            blurRadius: 2,
                            color: Colors.black.withOpacity(0.5)
                        )
                      ]).get(),

                ),
                color: Assets.blueColor,
                leftIcon: Icons.arrow_back,
                leftPath: '/home_page',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(50),
            child: RaisedButton(
                onPressed: () => Helper.go(context, '/test_area'),
                child: Text("test area 1")
            ),
          ),
          Column(
              children: [
                Form(
                  key: formkey,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          onSaved: saveData,
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          formkey.currentState.save();
                        },
                        child: Text("salvar"),
                      )
                    ],
                  ),
                ),
                isLoading
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    : Column(
                  children: [
                    TextBar(
                      texto: texto,
                    ),
                    GestureDetector(
                      onTap: () => Helper.go(context, "/home_page"),
                      child: TextBar(
                        texto: "Voltar",
                        size: 25,
                      ),
                    )
                  ],
                )
              ])

        ],
      ),
    );
  }
}