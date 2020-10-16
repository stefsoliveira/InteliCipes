import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projeto_3/Categorias.dart';
import 'package:projeto_3/assets_handler.dart';
import 'package:projeto_3/blocs/theme.dart';
import 'package:projeto_3/recommended_display.dart';
import 'package:provider/provider.dart';
import 'package:projeto_3/settings.dart';
import 'package:projeto_3/Receitas.dart';
import 'package:projeto_3/home_page.dart';
import 'package:projeto_3/widgets.dart';

void main() {
  dbInit();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      create: (_) => ThemeChanger(Themes.themel),
      child: MaterialAppTheme(),
    );
  }
}

class MaterialAppTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    //theme.themeData = Themes.themel;
    return MaterialApp(
      theme: theme.getTheme(),
      initialRoute: '/',
      routes: _buildRoutes(context),
    );
  }
}
_buildRoutes(context){
  return{
    '/':(context) => HomePage(),
    '/food_display':(context) => FoodDisplay(),
    '/settings':(context) => SettingsPage(),
    '/test_area':(context) => searchBar(),
  };

}
void dbInit(){
  var x = 11;
  var y = [Assets.Placeholder1,Assets.Placeholder2,Assets.Placeholder3,Assets.Placeholder4];
  var receita = Receita(
    titulo: "receita $x",
    tipo: "tipo $x",
    tempo: x+x,
    nIngredientes: x-2,

    ingredientes: ["ingrediente $x","ingrediente ${x+1}"],
  );
  receitaController.save(receita);
  for(int x = 1; x <= 10;x++){
    receita = Receita(
      titulo: "receita $x",
      tipo: "tipo $x",
      tempo: x+x,
      nIngredientes: x-2,
      image: y[Random().nextInt(4)],
      ingredientes: ["ingrediente $x","ingrediente ${x+1}"],
    );
    receitaController.save(receita);
  }
  for(int x = 1; x <= 9; x++){
    var categoria = Categorias(
      titulo: "categoria $x",
      image: y[Random().nextInt(4)]
    );
    categoriaControler.save(categoria);
  }
}