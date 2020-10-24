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

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPage createState() => _SplashPage();
}

class _SplashPage extends State<SplashPage> {
  bool isLoading = true;
  var texto = '';
  var formkey = GlobalKey<FormState>();
  bool timer = false;

  _fetchData() async {
//    print("this");
    if (pathControler.getPath() == null){
      pathControler.save('http://5e0f3902c114.ngrok.io/');
    }
    final response1 =
    await http.get("${pathControler.getPath()}get_recommended");
    final response2 =
    await http.get("${pathControler.getPath()}/list_groups");
    print(response1.statusCode);
    if (response1.statusCode != 200){
      Future wait = Future.delayed(Duration(seconds: 5));
      wait.then((value) => Helper.goReplace(context, '/home_page'));
      return null;
    }
    texto = response2.body.toString();
    recomendadoController.clear();
    categoriaControler.clear();
    mapData1(response1.body.toString());
    mapData2(response2.body.toString());
    Helper.goReplace(context, '/home_page');
  }

  mapData1(String jsonString) {
    Map<String, dynamic> jsonmap = jsonDecode(jsonString);
    jsonmap['recommended']
        .map<Receita>((json) => Receita.fromJson(json))
        .toList()
        .forEach((receita) => recomendadoController.save(receita));
//    print(recomendadoController.getAll());
  }
  mapData2(String jsonString) {
    Map<String, dynamic> jsonmap = jsonDecode(jsonString);
    jsonmap['grupos']
        .map<Categorias>((json) => Categorias.fromJson(json))
        .toList()
        .forEach((categoria) => categoriaControler.save(categoria));
//    print(categoriaControler.getall());
  }
  Future timerTick(){
    Future wait = Future.delayed(Duration(seconds: 10));
    wait.then((value) => timer = true);


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
          GestureDetector(
              onTap: () => Helper.goReplace(context, "/home_page"),
              child: Image(image: Assets.IntelicipesLogo01, height: 40,)),
          Assets.smallPaddingBox,
          Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: new AlwaysStoppedAnimation(Assets.whiteColor),
            ),
          ),
          timer ? TextBar(
            texto: 'Tap the Intelicipes logo to skip the loading.',
            theme: 'light',
            size: 7,
          )
          : Assets.smallPaddingBox,
          Spacer(),
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
//  for (int x = 1; x <= 9; x++) {
//    var categoria =
//        Categorias(titulo: "categoria $x", image: y[Random().nextInt(4)]);
//    categoriaControler.save(categoria);
//  }
}
