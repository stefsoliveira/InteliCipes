import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_3/assets_handler.dart';
import 'Receitas.dart';
import 'infra.dart';

class searchBar extends StatefulWidget{
  @override
  _searchBar createState() {
    return _searchBar();
  }
}
class _searchBar extends State<searchBar>{

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey,
      child: Scaffold(
        backgroundColor: Assets.whiteColor,
        body: Column(
          children: [
            InteliBar(
              leftIcon: Icons.arrow_back,
              leftPath: '/',
            ),
            SizedBox(height: 20,),
            ColectionBar(),
            TextBar(texto: 'teste',color: Assets.blackColorPlaceholder,padding: 3,)
            //ReceitaDisplay(titulo:null,ingredientes: [null,null],tempo: null,height_main: 230,image: Assets.Placeholder4,),
          ],
        ),
      ),
    );
  }
}

class InteliBar extends StatelessWidget{
  Color color;
  IconData leftIcon;
  String leftPath;
  IconData rightIcon;
  String rightPath;
  var title;
  InteliBar({this.color,this.leftIcon,this.leftPath,this.rightIcon,this.rightPath,this.title});

  Color setColor(color,placeholder){ // aplica um placeholder
    if (color == null){
      //print('InteliBar setColor = Placeholder');
      print(color);
      return placeholder;
    }
    else{
      return color;
    }
  }
  placeIcon(context,icon,path){
    if (icon == null){
      return SizedBox(width: 40,);
    }
    return IconButton(
      icon: Icon(icon),// placeholder : Icon(Icons.menu),
      onPressed: () => Helper.goReplace(context,path),
    );
  }
  setIcon(icon,placeholder){ // aplica um placeholder
    if (icon == null){
      //print('InteliBar setIcon = Placeholder');
      //return placeholder;
      return null;
    }
    else{
      return Icon(icon);
    }
  }
  setTitle(title,placeholder){
    if (title == null){
      //print('InteliBar setTitle = Placeholder');
      return placeholder;
    }
    else{
      return title;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Helper.getScreenWidth(context),
      height: 80,
      decoration: BoxDecoration(
        color: setColor(color,Assets.redColorPlaceholder),// placeholder : Assets.redColorPlaceholder
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Row(
              children: [
                SizedBox(width: 15,),
                placeIcon(context, leftIcon,leftPath),
                //IconButton(
                //    icon: setIcon(leftIcon, Icon(Icons.menu)),// placeholder : Icon(Icons.menu),
                //  onPressed: () => Helper.goReplace(context,leftPath),
                //),
                Spacer(),
                setTitle( title, Image(image:Assets.IntelicipesLogo01,height: 25,)), /*Image(image:Assets.IntelicipesLogo01,height: 25,),*/
                Spacer(),
                placeIcon(context, rightIcon, rightPath),
                //IconButton(
                //  icon: setIcon(rightIcon, Icon(Icons.more_vert)),// placeholder : Icon(Icons.more_vert),
                //  onPressed: ()=> Helper.goReplace(context,rightPath),
                //),
                SizedBox(width: 15,),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
class SearchBar extends StatelessWidget {
  Color color_main;
  Color color_icon;
  double barSize;
  String path,action;
  SearchBar({this.color_main,this.color_icon,this.barSize,this.path,this.action});
  void _ShowModal(BuildContext context){
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context)
        {
          return ModalSearchPage();
        },

    );
  }
  setPath(context){
    if (path == null){
      return null;
    }
    if (action == 'modal')
      return () => _ShowModal(context);
    if (action == 'go'){
      return () => Helper.go(context,path);
    }
    if (action == 'back'){
      return () => Helper.back(context);
    }
  }
  double setBarSize(size){
    if (barSize == null){
      return size - 20;
    }
    else{
      return size - barSize;
    }
  }
  Color setColor(color){
    if (color == null){
      return Assets.blackColorPlaceholder;
    }
    else{
      return color;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: setBarSize(Helper.getScreenWidth(context)),
        height: 40,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: setColor(color_main)
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [

                  Text("Pesquisar...",
                  style: Assets.inriaSans18dim,
                ),
                Spacer(),
                Icon(Icons.search,
                color: setColor(color_icon)),
                ]
              ),
            ),
          ]
        ),
      ),
      onTap: setPath(context),
    );
  }
}
class ReceitaDisplay extends StatelessWidget {
  String titulo;
  List ingredientes;
  int tempo;
  double height_main;
  AssetImage image;
  Color iconColor;

  ReceitaDisplay({this.titulo, this.ingredientes, this.tempo,this.height_main,this.image,this.iconColor});
  Widget imageCheck(width){
    if (image == null){
      return Container(
        height: height_main-60,
        decoration: BoxDecoration(
          color: Assets.blueColor,
        ),
      );
    }
    else{
      return
          Image.asset(image.assetName,
            scale: 0.3,
            width: width,
      );
    }
  }
  setColor(color){
    if (color == null) return Assets.blueColor;
    else return color;
  }
  getLen(String string,limit){
    if (string.length >= limit){
      return limit;
    }
    else return string.length;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        width: Helper.getScreenWidth(context),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            )
        ),
        child: Column(
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
                            Text("${this.titulo}",
                              style: InriaSansStyle(
                                size: 25
                              ).get(),
                            ),
                            Assets.smallPaddingBox,
                            Text("$tempo min",
                              style: Assets.inriaSans18dim,
                            ),
                            Icon(Icons.timer,
                              color:Colors.grey,),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),

                        child: Text("ingredientes: $ingredientes".replaceRange(getLen("ingredientes: $ingredientes",30), "ingredientes: $ingredientes".length, "..."), style: Assets.inriaSans18dim,),
                      )
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(Icons.favorite_border,
                      size: 40,
                      color: setColor(iconColor)),
                  )

                ],
              ),
              Assets.smallPaddingBox
            ]
        )
    );

  }
}

class TextBar extends StatelessWidget{
  Color color;
  String texto;
  double padding;
  TextStyle style;
  String theme;
  double size;
  String path,action;

  TextBar({this.size,this.color,this.texto,this.padding,this.style,this.theme,this.path,this.action});
  setPath(context){
    if (path == null){
      return null;
    }
    if (action == 'go'){
      return () => Helper.go(context,path);
    }
    if (action == 'back'){
      return () => Helper.back(context);
    }
  }
  setPadding(padding){
    if (padding == null){
      return 2;
    }
    else return padding;
  }
  setTheme(theme){
    if (theme == 'light'){
      this.color = Colors.white;
      this.padding = 4;
      this.style =  InriaSansStyle(
        color: Assets.darkGreyColor,
        size: size,
      ).get();
    }
    else if (theme == 'dark'){
      this.color = Assets.darkGreyColor;
      this.padding = 4;
      this.style =  InriaSansStyle(
        color: Assets.whiteColor,
        size: size,
      ).get();
    }
  }
  @override
  Widget build(BuildContext context){
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
          child: Text(texto,
          style: style
          ),
        )
      ),
    );
  }

} // themes 'dark' & 'light'
class ColectionItem extends StatelessWidget{
  AssetImage image;
  ColectionItem({this.image});
  setImage(image){
    if (image == null){
      return Container(
        color:Assets.whiteColor,
        height: 80,
        width: 80,
      );
    }
    else{
      return
        Image.asset(image.assetName,
          scale: 1,
          width: 80,
        );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Assets.whiteColor
      ),
      child: setImage(image),
    );
  }
}
class ColectionBar extends StatelessWidget{
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
                    itemBuilder: _ListBuilder
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _ListBuilder(context,index){
    return Container(
      child: Column(
        children: [
          SizedBox(height: 5,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3),
            child: ColectionItem(),
          ),
          SizedBox(height: 5,),
          TextBar(
            texto: "categoria $index",
            theme: 'light',
            size: 10,
          )],
      ),
    );
  }
}

class RecommendedDisplay extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: Assets.darkGreyColor
        ),
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
                  itemCount: 3,
                  itemBuilder: _buildList,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildList(context,index){
    return ListTile(
      title: _alterDisplay(index,
        ReceitaDisplay(
          titulo: "2",
          tempo: 1,
          ingredientes: [1,2],
          height_main: 240,
        ),
        Center(
          child: TextBar(
            path: '/food_display', //todo: area de recomendado
            action: 'go',
            texto: "mais...",
            padding: 10,
            color: Colors.white,
            style: InriaSansStyle(
              size: 18,
              color: Assets.darkGreyColor
            ).get(),
          ),
        ),
      ),
    );

  }
  _alterDisplay(index, widget1, widget2){
    if (index < 2) return widget1;
    else return widget2;
  }
}
class ModalSearchPage extends StatelessWidget {
  final _items = receitaController.getAll();

  @override
  Widget build(BuildContext context) {
    return
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: Assets.darkGreyColor
      ),
      clipBehavior: Clip.antiAlias,
      height: Helper.getScreenHeight(context)-80,
      width: Helper.getScreenWidth(context),
      child: Column(
        children: [
          Assets.smallPaddingBox,
          Hero( // animaçao entre as telas
              tag:'searchbar',
              child:Material(
                color: Colors.transparent,
                child: SearchBar(
                  color_main:Assets.whiteColor,
                  color_icon:Assets.blackColorPlaceholder,
                  barSize: 30,
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
      ),
    );
  }
  Widget _buildListTile(context,index) {
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
                    blurRadius: 5
                )
              ]
          ),
          child: ReceitaDisplay(
            titulo: _receita.titulo,
            ingredientes: _receita.ingredientes,
            tempo: _receita.tempo,
            image: _receita.image,
            height_main: 230,
            iconColor: Assets.blueColor,
          )
      ),
    );
  }
}