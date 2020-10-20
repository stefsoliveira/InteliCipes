import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Categorias.dart';
import 'assets_handler.dart';
import 'blocs/theme.dart';
import 'http service.dart';
import 'infra.dart';
import 'recommended_display.dart';
import 'package:provider/provider.dart';
import 'settings.dart';
import 'Receitas.dart';
import 'home_page.dart';
import 'widgets.dart';
import 'package:http/http.dart' as http;

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

_buildRoutes(context) {
  return {
    '/': (context) => SplashPage(),
    '/home_page': (context) => HomePage(),
    '/food_display': (context) => FoodDisplay(),
    '/settings': (context) => SettingsPage(),
    '/test_area': (context) => searchBar(),
  };
}

///_processData(jsonString) {
///  Map<String, dynamic> jsonMaps = jsonDecode(jsonString);
///  jsonMaps['alunos']
///      .map<Aluno>((json) => Aluno.fromJson(json))
///      .toList()
///      .forEach((aluno) => alunoController.save(aluno));
///}
class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPage createState() => _SplashPage();
}

class _SplashPage extends State<SplashPage> {
  bool isLoading = true;
  var texto = '';
  var formkey = GlobalKey<FormState>();

  _fetchData() async {
    if (pathControler.getPath() == null){
      Future wait = Future.delayed(Duration(seconds: 5));
      wait.then((value) => Helper.goReplace(context, '/home_page'));
      return null;
    }
    final response =
    await http.get("${pathControler.getPath()}get_recommended");
    texto = response.body.toString();
    return mapData(response.body.toString());
  }

  mapData(String jsonString) {
    Map<String, dynamic> jsonmap = jsonDecode(jsonString);
    jsonmap['recommended']
        .map<Receita>((json) => Receita.fromJson(json))
        .toList()
        .forEach((receita) => recomendadoController.save(receita));
    Helper.goReplace(context, '/home_page');
  }

  @override
  Widget build(BuildContext context) {
    _fetchData();
    // TODO: implement build
    return Scaffold(
      backgroundColor: Assets.blueColor,
      body: Column(
        children: [

          Spacer(),
          Image(image: Assets.IntelicipesLogo01, height: 40,),
          Assets.smallPaddingBox,
          Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: new AlwaysStoppedAnimation(Assets.whiteColor),
            ),
          ),
          Spacer(),
          RaisedButton(
            onPressed:() => Helper.goReplace(context, '/home_page'),
            child: Text("home_page"),
          )
        ],
      ),
    );
  }
}

void dbInit() {
  var x = 11;
  var y = [
    Assets.Placeholder1,
    Assets.Placeholder2,
    Assets.Placeholder3,
    Assets.Placeholder4
  ];
  var receita = Receita(
    titulo: "receita $x",
    tipo: "tipo $x",
    tempo: x + x,
    nIngredientes: x - 2,
    ingredientes: ["ingrediente $x", "ingrediente ${x + 1}"],
  );
  receitaController.save(receita);
//  for (int x = 1; x <= 10; x++) {
//    receita = Receita(
//      titulo: "receita $x",
//      tipo: "tipo $x",
//      tempo: x + x,
//      nIngredientes: x - 2,
//      image: y[Random().nextInt(4)],
//      ingredientes: ["ingrediente $x", "ingrediente ${x + 1}"],
//    );
//    receitaController.save(receita);
//  }
  for (int x = 1; x <= 9; x++) {
    var categoria =
        Categorias(titulo: "categoria $x", image: y[Random().nextInt(4)]);
    categoriaControler.save(categoria);
  }
}
