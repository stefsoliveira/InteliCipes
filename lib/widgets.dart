import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:projeto_3/Favoritos.dart';
import 'dart:convert';
import 'package:projeto_3/assets_handler.dart';
import 'package:projeto_3/Receitas.dart';
import 'package:projeto_3/Categorias.dart';
import 'package:projeto_3/http%20service.dart';
import 'package:projeto_3/infra.dart';
import 'package:projeto_3/recommended_display.dart';

class searchBar extends StatefulWidget {
  @override
  _searchBar createState() {
    return _searchBar();
  }
} // area de teste que convenientemente se chama searchbar

class _searchBar extends State<searchBar> {
  var _controler = TextEditingController();
  _showModal(){
    showModalBottomSheet(
      isScrollControlled: true,
        context: context,
        builder: (context){
      return RecipeDisplay(

      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Column(
          children: [
            ReceitaDisplay(
              titulo: 'opa',
              height_main: 200,
            ),
            Spacer(),
            RaisedButton(
              onPressed: () =>_showModal(),
              child: TextBar(texto: 'abrir',),
            ),
            Spacer()
          ],
        ),
      )
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
  String path, action, text;
  Function onSaved;

  SearchBar(
      {this.isForm,
      this.colorMain,
      this.colorIcon,
      this.barSize,
      this.path,
      this.action,
      this.onSaved,
      this.text = "Pesquisar..."});

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
              Text(widget.text, style: Assets.inriaSans18dim),
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
  var ingredientes, preparo, group;
  var tempo;
  double height_main;
  double width_main;
  bool hasWidth;
  AssetImage image;
  Color iconColor;
  bool isLiked;
  var id;

  ReceitaDisplay(
      {this.titulo,
      this.ingredientes,
      this.tempo,
      this.height_main,
      this.width_main,
      this.hasWidth = false,
      this.image,
      this.iconColor,
      this.preparo,
      this.isLiked = false,
      this.id,
        this.group
      });

  @override
  _ReceitaDisplayState createState() => _ReceitaDisplayState();
}

class _ReceitaDisplayState extends State<ReceitaDisplay> {

  _showModal(){
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context){
          return RecipeDisplay(
            titulo: widget.titulo,
            tempo: widget.tempo,
            ingredientes: widget.ingredientes,
            preparo: widget.preparo,
            group: widget.group,
          );
        });
  }

  Widget imageCheck(width) {
    if (widget.image == null) {
      return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
          _showModal();
          print("this ${widget.titulo} , id: ${widget.id}");//299989
          print("this ${widget.group} , id: ${widget.id}");//299989
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
                              "...").replaceAll('[', '').replaceAll(']', '').replaceAll("'", ''),
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
//                          print(favoritosController.isFaved(widget.id));
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
  int cluster;
  int index;
  ColectionItem({this.index,this.image,this.cluster});

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
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => FoodDisplay(argument: [index,cluster])));

      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        height: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Assets.whiteColor),
        child: setImage(image),
      ),
    );
  }
} // Tile da aba de categorias. Possue uma imagem(asset),titulo(string)

class ColectionBar extends StatefulWidget {
  @override
  _ColectionBarState createState() => _ColectionBarState();
}

class _ColectionBarState extends State<ColectionBar> {

  var _items = categoriaControler.getall();

  @override

  Widget build(BuildContext context) {
    var len = _items.length;
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
                    itemCount: len,
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
              index: int.parse(_categoria.count),
              cluster: int.parse(_categoria.grupoID),
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
//                GestureDetector(
//                  onTap: (){
////                    print(favoritosController.getall());
//                  },
//                  child: Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: TextBar(
//                      texto: "print",
//                      theme: 'light',
//                      size: 15,
//                    ),
//                  ),
//                ),

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
      title: ReceitaDisplay(
        titulo: item.titulo,
        tempo: item.tempo,
        ingredientes: item.ingredientes,
        preparo: item.preparo,
        id: item.index,
        height_main: 240,
        group: item.tipo,
      ),
    );
  }

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
                    ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Assets.whiteColor),
                    strokeWidth: 2,
                  ),)
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
            preparo: _receita.preparo,
            height_main: 230,
            iconColor: Assets.blueColor,
            group: _receita.tipo,
          )),
    );
  }
} // Modal de pesquisa que pertence a aba SearchBar

class RecipeDisplay extends StatelessWidget {
  String titulo;
  var ingredientes, preparo;
  var tempo,group;
  AssetImage image;
  var id;

  RecipeDisplay({this.titulo = 'placeholder',
    this.ingredientes,
    this.tempo,
    this.image,
    this.preparo,
    this.id,
    this.group
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Helper.getScreenHeight(context) * 0.8,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: Colors.white
      ),
      child: ListView(
        children: [
          Container(
            width: Helper.getScreenWidth(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 240,
                  decoration: BoxDecoration(
                    color: Assets.blueColor,
                  ),),
//                Image.asset(
//                  Assets.Placeholder1.assetName,
//                  scale: 0.3,
//                  fit: BoxFit.fill,
//                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4, top: 1),
                  child: Container(
                    width: Helper.getScreenWidth(context) - 8,
                    child: TextBar(
                      texto: '$titulo',
                      size: 30,
                      theme: 'light',
                    ),
                  ),
                ),
                Container(
                    child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left:4),
                            child: TextBar(
                              texto: '$tempo min',
                              size: 15,
                              theme: 'light',
                            ),
                          ),
                          Icon(Icons.timer,
                              size: 20,
                              color: Assets.darkGreyColor)
                        ]
                    )
                ),
                Divider(),
                ///-----------------------------------------------------------------//////-----------------------------------------------------------------///
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    height: 300,
                      child: ListView(
                        children: [
                          SimmilarRecipes(
                          titulo: 'Receitas similares por calorias',
                            id: id,
                            path: group[0],
                            grupo: '0',
                        ),
                          SimmilarRecipes(
                            path: group[1],
                            id: id,
                            titulo: 'Receitas similares por proteinas',
                            grupo: '1',
                          ),
                          SimmilarRecipes(
                            path: group[2],
                            id: id,
                            titulo: 'Receitas similares por açucares',
                            grupo: '2',
                          ),
                        ]
                      )
                  ),
                ),
                ///-----------------------------------------------------------------//////-----------------------------------------------------------------///
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Container(
                        width: Helper.getScreenWidth(context) - 8,
                        child: TextBar(
                          theme: 'dark',
                          texto: "Ingredientes:",
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: Helper.getScreenWidth(context) - 8,
                  child: TextBar(
                    theme: 'light',
                    texto: '$ingredientes'.replaceAll("[", '').replaceAll("'", '').replaceAll(']', ''),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: Helper.getScreenWidth(context) - 8,
                      child: TextBar(
                        texto: "Modo de Preparo: ",
                        theme: 'dark',
                        size: 20,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(4),
                  child: Container(
                    width: Helper.getScreenWidth(context) - 8,
                    child: TextBar(
                      theme: 'light',
                      texto: "-$preparo"
                          .replaceAll("]", '')
                          .replaceAll("', '", '\n -')
                          .replaceAll("[", ''),
                    ),
                  ),
                )

                ///--------------------------------------------------------

              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SimmilarRecipes extends StatefulWidget{

  String titulo;
  String path;
  String id;
  String grupo;

  SimmilarRecipes({this.titulo = 'Placeholder',this.id,this.path,this.grupo});
  @override
  _SimmilarRecipesState createState() => _SimmilarRecipesState();
}

class _SimmilarRecipesState extends State<SimmilarRecipes> {
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
//    print('init');
  }

  void _loadMore() {
//    print("loadmore");
    _isLoading = true;
    _itemFetcher.fetch(widget.grupo,widget.path).then((List fetchedList) {
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
    int lenPlus = items.length + 1;
    int len = items.length;
    return Container(
      height: 260,
      color: Assets.darkGreyColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextBar(texto: '${widget.titulo}',),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _hasMore ? lenPlus : len,
              itemBuilder: _builder,
            ),
          ),
        ],
      ),
    );
  }

  Widget _builder(context, index) {
    if (index >= items.length) {
      if (!_isLoading) {
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
    return Container(
      padding: EdgeInsets.all(4),
      width: Helper.getScreenWidth(context),
      child: ReceitaDisplay(
        titulo: _items.titulo,
        tempo: _items.tempo,
        ingredientes: _items.ingredientes,
        preparo: _items.preparo,
        height_main: 236,
        group: _items.tipo
      ),
    );
  }
}


class _ItemFetcher {
  int _pageCount = 0;

  Future<List>fetch(grupo,cluster) async {
    print('fetch :$grupo');
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
