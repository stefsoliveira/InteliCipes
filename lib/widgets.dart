import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:projeto_3/Favoritos.dart';
import 'dart:convert';
import 'package:projeto_3/assets_handler.dart';
import 'package:projeto_3/Receitas.dart';
import 'package:projeto_3/Categorias.dart';
import 'package:projeto_3/http%20service.dart';
import 'package:projeto_3/infra.dart';

class searchBar extends StatefulWidget {
  @override
  _searchBar createState() {
    return _searchBar();
  }
} // area de teste que convenientemente se chama searchbar

class _searchBar extends State<searchBar> {
  var _controler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Material(
        color: Colors.grey,
        child: Scaffold(
          backgroundColor: Assets.whiteColor,
          body: Column(
            children: [
              RecipePage()
            ],
          )

          ),
        ),
      );
  }
} // area de teste

class InteliBar extends StatelessWidget {
  Color color;
  IconData leftIcon;
  String leftPath;
  IconData rightIcon;
  String rightPath;
  var title;

  InteliBar(
      {this.color,
      this.leftIcon,
      this.leftPath,
      this.rightIcon,
      this.rightPath,
      this.title});

  Color setColor(color, placeholder) {
    if (color == null) {
      return placeholder;
    } else {
      return color;
    }
  }

  placeIcon(context, icon, path) {
    if (icon == null) {
      return SizedBox(
        width: 40,
      );
    }
    return IconButton(
      icon: Icon(icon), // placeholder : Icon(Icons.menu),
      onPressed: () => Helper.goReplace(context, path),
    );
  }

  setIcon(icon, placeholder) {

    if (icon == null) {

      return null;
    } else {
      return Icon(icon);
    }
  }

  setTitle(title, placeholder) {
    if (title == null) {
      //print('InteliBar setTitle = Placeholder');
      return placeholder;
    } else {
      return title;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Helper.getScreenWidth(context),
      height: 80,
      decoration: BoxDecoration(
          color: setColor(color, Assets.redColorPlaceholder),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                placeIcon(context, leftIcon, leftPath),
                Spacer(),
                setTitle(
                    title,
                    Image(
                      image: Assets.IntelicipesLogo01,
                      height: 25,
                    )),
                Spacer(),
                placeIcon(context, rightIcon, rightPath),
                SizedBox(
                  width: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} // AppBar Customizado, é só por num Column dentro de um Scaffold. (nao colocar na area de Appbar pois isto é um Widget)

class SearchBar extends StatefulWidget {
  Color colorMain, colorIcon;
  double barSize;
  bool isForm;
  String path, action;
  Function onSaved;

  SearchBar(
      {this.isForm,
      this.colorMain,
      this.colorIcon,
      this.barSize,
      this.path,
      this.action,
      this.onSaved});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  var _controller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  void _ShowModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return ModalSearchPage();
      },
    );
  }

  setPath(context) {
    if (widget.path == null) {
      return () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      };
    }
    if (widget.action == 'modal') return () => _ShowModal(context);
    if (widget.action == 'go') {
      return () => Helper.go(context, widget.path);
    }
    if (widget.action == 'back') {
      return () => Helper.back(context);
    }
  }

  double setBarSize(size) {
    if (widget.barSize == null) {
      return size - 20;
    } else {
      return size - widget.barSize;
    }
  }

  Color setColor(color) {
    if (color == null) {
      return Assets.blackColorPlaceholder;
    } else {
      return color;
    }
  }

  setText(isform, context) {
    if (isform == true) {
      return Expanded(
        child: Container(
          child: Form(
            key: formkey,
            child: Row(
              children: [
                Assets.smallPaddingBox,
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: TextFormField(
                      onSaved: widget.onSaved,
                      autofocus: true,
                      controller: _controller,
                      onTap: () {
                        setState(() {
                          _controller.selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: _controller.text.length);
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "pesquisar",
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    formkey.currentState.save();
                  },
                  icon: Icon(Icons.search),
                )
              ],
            ),
          ),
        ),
      );
    } else
      return Expanded(
        child: Container(
            child: Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Row(
            children: [
              Assets.smallPaddingBox,
              Text("Pesquisar...", style: Assets.inriaSans18dim),
              Spacer(),
              Icon(Icons.search, color: setColor(widget.colorIcon))
            ],
          ),
        )),
      );
  }

  setIcon(isform, context) {
    if (isform == true) {
      return SizedBox();
    } else
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.search, color: setColor(widget.colorIcon)),
      );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: setPath(context),
      child: Container(
        width: setBarSize(Helper.getScreenWidth(context)),
        height: 40,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: setColor(widget.colorMain)),
        child: Row(children: [
          setText(widget.isForm, context),
          Assets.smallPaddingBox,
        ]),
      ),
    );
  }
} // Barra de pesquisa que tem 2 funçoes: Botao,Form. Modal pertence a essa classe

class ReceitaDisplay extends StatefulWidget {
  String titulo;
  var ingredientes, preparo;
  var tempo;
  double height_main;
  AssetImage image;
  Color iconColor;
  bool isLiked;
  var id;

  ReceitaDisplay(
      {this.titulo,
      this.ingredientes,
      this.tempo,
      this.height_main,
      this.image,
      this.iconColor,
      this.preparo,
      this.isLiked = false,
      this.id});

  @override
  _ReceitaDisplayState createState() => _ReceitaDisplayState();
}

class _ReceitaDisplayState extends State<ReceitaDisplay> {
  Widget imageCheck(width) {
    if (widget.image == null) {
      return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
          print("this ${widget.titulo} , id: ${widget.id}");//299989
        },
        child: Container(
          height: widget.height_main - 60,
          decoration: BoxDecoration(
            color: Assets.blueColor,
          ),
        ),
      );
    } else {
      return Image.asset(
        widget.image.assetName,
        scale: 0.3,
        width: width,
      );
    }
  }

  setFav(id){
    widget.isLiked = favoritosController.isFaved(id);
    if (widget.isLiked){
      return Icon(Icons.favorite,
          size: 40, color: setColor(widget.iconColor));
    }
    else
      return Icon(Icons.favorite_border,
          size: 40, color: setColor(widget.iconColor));
  }

  setColor(color) {
    if (color == null)
      return Assets.blueColor;
    else
      return color;
  }

  getLen(String string, limit) {
    if (string.length >= limit) {
      return limit;
    } else
      return string.length;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.antiAlias,
        width: Helper.getScreenWidth(context),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            )),
        child:
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              imageCheck(Helper.getScreenWidth(context)),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Text(
                              "${this.widget.titulo}".replaceRange(
                                  getLen("${widget.titulo}", 14), "${widget
                                  .titulo}".length, "..."),
                              style: InriaSansStyle(size: 20).get(),
                            ),
                            Assets.smallPaddingBox,
                            Text(
                              "${widget.tempo} min",
                              style: InriaSansStyle(
                                  size: 15, color: Colors.grey.shade900)
                                  .get(),
                            ),
                            Icon(
                              Icons.timer,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "${widget.ingredientes}".replaceRange(
                              getLen(
                                  "${widget.ingredientes}", 35),
                              "${widget.ingredientes}".length,
                              "..."),
                          style: InriaSansStyle(
                            size: 15,
                            color: Colors.grey,
                          ).get(),
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GestureDetector(
                      onTap: (){
                        favoritosController.update(widget.id);
                        setState(() {
                          print(favoritosController.isFaved(widget.id));
                        });
                      },
                      child: setFav(widget.id),
                    )
                  )
                ],
              ),
              Assets.smallPaddingBox
            ]));
  }
} // Tile que mostra uma imagem(asset), titulo(string), tempo(int), ingredientes(list). Pode ser usado ''standalone''.

class TextBar extends StatelessWidget {
  Color color;
  double padding, size;
  TextStyle style;
  FontStyle fontStyle;
  FontWeight fontWeight;
  String theme, texto, path, action;

  TextBar(
      {this.size = 15,
      this.color,
      this.texto = 'placeholder',
      this.padding,
      this.style,
      this.theme = 'dark',
      this.path,
      this.action,
      this.fontWeight,
      this.fontStyle});

  setPath(context) {
    if (path == null) {
      return null;
    }
    if (action == 'go') {
      return () => Helper.go(context, path);
    }
    if (action == 'back') {
      return () => Helper.back(context);
    }
  }

  setPadding(padding) {
    if (padding == null) {
      return 2;
    } else
      return padding;
  }

  setTheme(theme) {
    if (theme == 'light') {
      this.color = Colors.white;
      this.padding = 4;
      this.style = InriaSansStyle(
        color: Assets.darkGreyColor,
        size: size,
        fontWeight: fontWeight,
      ).get();
    } else if (theme == 'dark') {
      this.color = Assets.darkGreyColor;
      this.padding = 4;
      this.style = InriaSansStyle(
        color: Assets.whiteColor,
        size: size,
      ).get();
    }
  }

  @override
  Widget build(BuildContext context) {
    setTheme(theme);
    return InkWell(
      onTap: setPath(context),
      child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Text(texto, style: style),
          )),
    );
  }
} // Texto(string) dentro de uma capsula. possuem os themes 'dark' & 'light'.

class ColectionItem extends StatelessWidget {
  AssetImage image;

  ColectionItem({this.image});

  setImage(image) {
    if (image == null) {
      return Container(
        color: Assets.whiteColor,
        height: 80,
        width: 80,
      );
    } else {
      return Image.asset(
        image.assetName,
        scale: 1,
        height: 80,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Assets.whiteColor),
      child: setImage(image),
    );
  }
} // Tile da aba de categorias. Possue uma imagem(asset),titulo(string)

class ColectionBar extends StatelessWidget {
  var _items = categoriaControler.getall();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Assets.darkGreyColor,
        ),
        height: 110,
        clipBehavior: Clip.antiAlias,
        width: Helper.getScreenWidth(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              color: Colors.transparent,
              child: Container(
                height: 110,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: _ListBuilder),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ListBuilder(context, index) {
    var __categoria = _items;
    var _categoria = __categoria[index];
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3),
            child: ColectionItem(
              image: _categoria.image,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          TextBar(
            texto: _categoria.titulo,
            theme: 'light',
            size: 10,
          )
        ],
      ),
    );
  }
} // Um listView dos Tiles das categorias

class RecommendedDisplay extends StatefulWidget {
  @override
  _RecommendedDisplayState createState() => _RecommendedDisplayState();
}

class _RecommendedDisplayState extends State<RecommendedDisplay> {

  var _recomendedList = recomendadoController.getAll();

  @override
  Widget build(BuildContext context) {
    var len = _recomendedList.length;
    return Expanded(
      child: Container(
        width: Helper.getScreenWidth(context) - 16,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            color: Assets.darkGreyColor),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextBar(
                    texto: "Recomendados",
                    theme: 'light',
                    size: 15,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    print(favoritosController.getall());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextBar(
                      texto: "print",
                      theme: 'light',
                      size: 15,
                    ),
                  ),
                ),

              ],
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  padding: EdgeInsets.all(1),
                  itemCount: len,
                  itemBuilder: _buildList,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(context, index) {
    Receita item;
    if (_recomendedList.length == 0) {
      item = Receita();
    } else
      item = _recomendedList[index];
    return ListTile(
      title: _alterDisplay(
        index,
        ReceitaDisplay(
          titulo: item.titulo,
          tempo: item.tempo,
          ingredientes: item.ingredientes,
          id: item.index,
          height_main: 240,
        ),
        Center(
          child: TextBar(
            path: '/food_display',
            action: 'go',
            texto: "mais...",
            size: 20,
            padding: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }//todo: area de recomendado

  _alterDisplay(index, widget1, widget2) {
    if (index <= _recomendedList.length-2) {
      return widget1;
    }
    else
      return widget2;
  }
} // Um listView que mostra N instancias de ReceitaDisplay e no final um botao ''Mais''

class ModalSearchPage extends StatefulWidget {
  @override
  _ModalSearchPageState createState() => _ModalSearchPageState();
}

class _ModalSearchPageState extends State<ModalSearchPage> {
  bool isLoading = false;

  var texto = '';

  var list;

  _fetchData(pesquisa) async {
    pesquisaController.clear();
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get("${pathControler.getPath()}search_name/$pesquisa");


    texto = response.body.toString();
    return mapData(response.body.toString());
  }

  mapData(String jsonString) {
    Map<String, dynamic> jsonmap = jsonDecode(jsonString);
    jsonmap['pesquisa']
        .map<Receita>((json) => Receita.fromJson(json))
        .toList()
        .forEach((receita) => pesquisaController.save(receita));
    _items = pesquisaController.getAll();
    setState(() {
      isLoading = false;
    });
  }

  var _items = pesquisaController.getAll();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                color: Assets.darkGreyColor),
            clipBehavior: Clip.antiAlias,
            height: Helper.getScreenHeight(context) - 25,
            width: Helper.getScreenWidth(context),
            child: Column(
              children: [
                Assets.smallPaddingBox,
                SearchBar(
                  colorMain: Assets.whiteColor,
                  colorIcon: Assets.blackColorPlaceholder,
                  barSize: 30,
                  isForm: true,
                  onSaved: (input) {
                    setState(() {
                      _fetchData(input);
                    });
                  },
                ),
                Assets.smallPaddingBox,
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: Container(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.all(0),
                            itemCount: _items.length,
                            itemBuilder: _buildListTile,
                          ),
                        ),
                      ),
              ],
            )));
  }

  Widget _buildListTile(context, index) {
    var __receita = _items;
    Receita _receita = __receita[index];
    return ListTile(
      visualDensity: VisualDensity.compact,
      title: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.7),
                    offset: Offset(0, 3),
                    blurRadius: 5)
              ]),
          child: ReceitaDisplay(
            titulo: _receita.titulo,
            ingredientes: _receita.ingredientes,
            tempo: _receita.tempo,
            image: _receita.image,
            id: _receita.index,
            height_main: 230,
            iconColor: Assets.blueColor,
          )),
    );
  }
} // Modal de pesquisa que pertence a aba SearchBar

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
    return Expanded(
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

} // todo: pagina de likes, pagina de receitas.
