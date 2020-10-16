import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_3/assets_handler.dart';
import 'package:projeto_3/blocs/theme.dart';
import 'package:projeto_3/widgets.dart';
import 'package:provider/provider.dart';
import 'package:projeto_3/infra.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);

    return Scaffold(
      backgroundColor: Assets.darkGreyColor,
    /*appBar: AppBar(
        actions: [
          Icon(
            Icons.search
          ),
          SizedBox(
            width: 30,
          )
        ],
      ),*/
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
                          offset: Offset(0,2),
                          blurRadius: 2,
                          color: Colors.black.withOpacity(0.5)
                      )
                    ]).get(),

                ),
                color: Assets.blueColor,
                leftIcon: Icons.arrow_back,
                leftPath: '/',
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Row(
              children: [
                RaisedButton(
                  onPressed: ()=>_themeChanger.setTheme(Themes.themed),
                  child: Text("dark Theme"),
                ),
                Spacer(),
                RaisedButton(
                  onPressed: ()=>_themeChanger.setTheme(Themes.themel),
                  child: Text("light Theme"),
                )
              ],
            ),
          ),

          
          Padding(
            padding: EdgeInsets.all(50),
            child: Row(
              children: [
                RaisedButton(
                  onPressed: ()=> Helper.go(context,'/test_area'),
                  child: Text("test area 1")
                ),
                RaisedButton(
                  onPressed: ()=> Helper.go(context,'/test_area2'),
                  child: Text("test area 2")
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}