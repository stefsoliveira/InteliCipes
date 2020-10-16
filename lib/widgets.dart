import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:projeto_3/assets_handler.dart';
import 'package:projeto_3/Receitas.dart';
import 'package:projeto_3/Categorias.dart';
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
              InteliBar(
                leftIcon: Icons.arrow_back,
                leftPath: '/',
              ),
              SizedBox(
                height: 20,
              ),
              SearchBar(
                colorIcon: Assets.whiteColor,
                isForm: true,
              ),
              ColectionBar(),
              TextBar(
                texto: 'teste',
                color: Assets.blackColorPlaceholder,
                padding: 3,
              ),
              TextFormField(
                controller: _controler,
                onTap: () {
                  setState(() {
                    _controler.clear();
                  });
                },
              )
              //ReceitaDisplay(titulo:null,ingredientes: [null,null],tempo: null,height_main: 230,image: Assets.Placeholder4,),
            ],
          ),
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
    // aplica um placeholder
    if (color == null) {
      //print('InteliBar setColor = Placeholder');
      print(color);
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
    // aplica um placeholder
    if (icon == null) {
      //print('InteliBar setIcon = Placeholder');
      //return placeholder;
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
          // placeholder : Assets.redColorPlaceholder
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
                //IconButton(
                //    icon: setIcon(leftIcon, Icon(Icons.menu)),// placeholder : Icon(Icons.menu),
                //  onPressed: () => Helper.goReplace(context,leftPath),
                //),
                Spacer(),
                setTitle(
                    title,
                    Image(
                      image: Assets.IntelicipesLogo01,
                      height: 25,
                    )),
                /*Image(image:Assets.IntelicipesLogo01,height: 25,),*/
                Spacer(),
                placeIcon(context, rightIcon, rightPath),
                //IconButton(
                //  icon: setIcon(rightIcon, Icon(Icons.more_vert)),// placeholder : Icon(Icons.more_vert),
                //  onPressed: ()=> Helper.goReplace(context,rightPath),
                //),
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

  SearchBar(
      {this.isForm,
      this.colorMain,
      this.colorIcon,
      this.barSize,
      this.path,
      this.action});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  var _controller = TextEditingController();

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
          child: Row(
            children: [
              Assets.smallPaddingBox,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: TextFormField(
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
                  setState(() {
                    print(_controller.text);
                  });
                },
                icon: Icon(Icons.search),
              )
            ],
          ),
//          child: TextFormField(
//            controller: _controller,
//            style: InriaSansStyle(
//              color: Assets.darkGreyColor,
//              size: 18,
//              fontStyle: FontStyle.italic,
//            ).get(),
//            decoration: InputDecoration(
//              contentPadding: EdgeInsets.all(8),
//              hintText: "Pesquisar",
//              suffixIcon: IconButton(
//                  icon: Icon(Icons.clear),
//                  color: Colors.black,
//                  onPressed: () {
//                    print('this');
//                    _controller.clear();
//                  }),
//            ),
//          ),
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

class ReceitaDisplay extends StatelessWidget {
  String titulo;
  List ingredientes, preparo;
  var tempo;
  double height_main;
  AssetImage image;
  Color iconColor;

  ReceitaDisplay(
      {this.titulo,
      this.ingredientes,
      this.tempo,
      this.height_main,
      this.image,
      this.iconColor,
      this.preparo});

  Widget imageCheck(width) {
    if (image == null) {
      return Container(
        height: height_main - 60,
        decoration: BoxDecoration(
          color: Assets.blueColor,
        ),
      );
    } else {
      return Image.asset(
        image.assetName,
        scale: 0.3,
        width: width,
      );
    }
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
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        print("this $titulo");
      },
      child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          width: Helper.getScreenWidth(context),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              )),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                            "${this.titulo}".replaceRange(
                                getLen("$titulo", 16), "$titulo".length, "..."),
                            style: InriaSansStyle(size: 20).get(),
                          ),
                          Assets.smallPaddingBox,
                          Text(
                            "$tempo min",
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
                        "ingredientes: $ingredientes".replaceRange(
                            getLen("ingredientes: $ingredientes", 35),
                            "ingredientes: $ingredientes".length,
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
                  child: Icon(Icons.favorite_border,
                      size: 40, color: setColor(iconColor)),
                )
              ],
            ),
            Assets.smallPaddingBox
          ])),
    );
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

class RecommendedDisplay extends StatelessWidget {
  var _recomendedList = recomendadoController.getAll();

  @override
  Widget build(BuildContext context) {
    print(_recomendedList.length);
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            color: Assets.darkGreyColor),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextBar(
                texto: "Recomendados",
                theme: 'light',
                size: 15,
              ),
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  padding: EdgeInsets.all(1),
                  itemCount: (1),
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
    var item;
    if (_recomendedList.length == 0) {
      item = Receita();
    }
    else item = _recomendedList[index];
    return ListTile(
      title: _alterDisplay(
        index,
        ReceitaDisplay(
          titulo: item.titulo,
          tempo: item.tempo,
          ingredientes: item.ingredientes,
          height_main: 240,
        ),
        Center(
          child: TextBar(
            path: '/food_display',
            //todo: area de recomendado
            action: 'go',
            texto: "mais...",
            size: 20,
            padding: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  _alterDisplay(index, widget1, widget2) {
    if (index < _recomendedList.length)
      return widget1;
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

  _fetchData(pesquisa) async{
    setState(() {
      isLoading = true;
    });
    final response =
    await http.get("http://87f32e69d5a6.ngrok.io/get_recommended");

    setState(() {
      isLoading = false;
    });
    texto = response.body.toString();
    return mapData(response.body.toString());
  }

  mapData(String jsonString){
    Map<String, dynamic> jsonmap = jsonDecode(jsonString);
    jsonmap['recommended']
        .map<Receita>((json)=> Receita.fromJson(json))
        .toList()
        .forEach((receita)=> receitaController.save(receita));
    Receita a = pesquisaController.getAll()[1];
    print([a.titulo,a.tempo,a.image,a.nIngredientes,a.index,a.preparo,a.tipo]);

  }

  final _items = pesquisaController.getAll();

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
        child: isLoading
        ?  Center(child: CircularProgressIndicator()): Column(
          children: [
            Assets.smallPaddingBox,
            Hero(
              // animaçao entre as telas
                tag: 'searchbar',
                child: Material(
                  color: Colors.transparent,
                  child: SearchBar(
                    colorMain: Assets.whiteColor,
                    colorIcon: Assets.blackColorPlaceholder,
                    barSize: 30,
                    isForm: true,
                  ),
                )),
            Assets.smallPaddingBox,
            Expanded(
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
        )

      ),
    );
  }

  Widget _buildListTile(context, index) {
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
                    offset: Offset(0, 3),
                    blurRadius: 5)
              ]),
          child: ReceitaDisplay(
            titulo: _receita.titulo,
            ingredientes: _receita.ingredientes,
            tempo: _receita.tempo,
            image: _receita.image,
            height_main: 230,
            iconColor: Assets.blueColor,
          )),
    );
  }
} // Modal de pesquisa que pertence a aba SearchBar

class ReceitaPage extends StatelessWidget {
  @override
  Widget build(BuildContext Context) {
    return Scaffold();
  }
} // todo: pagina de likes, pagina de receitas.
