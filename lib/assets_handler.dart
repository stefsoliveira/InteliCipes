import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Assets{
  static final AssetImage IntelicipesLogo01 = AssetImage("extra/Images/bitmap 01.png");
  static final AssetImage IntelicipesLogo02 = AssetImage("extra/Images/bitmap 02.png");
  static final AssetImage IntelicipesLogo03 = AssetImage("extra/Images/bitmap 03.png");
  static final AssetImage Placeholder1 = AssetImage("extra/Images/placeholder comida.png");
  static final AssetImage Placeholder2 = AssetImage("extra/Images/placeholder comida 02.png");
  static final AssetImage Placeholder3 = AssetImage("extra/Images/placeholder comida 03.png");
  static final AssetImage Placeholder4 = AssetImage("extra/Images/placeholder comida 04.png");
  static final AssetImage Display01 = AssetImage("extra/Images/receita 01.png");
  static final SizedBox smallPaddingBox = SizedBox(height: 8,width: 8);
  static final Color redColorPlaceholder = Color(0xfff8333c);
  static final Color blackColorPlaceholder = Color(0xff2d3142);
  static final Color yellowColorPlaceholder = Color(0xfffcab10);
  static final Color whiteColor = Color(0xffFDFFFC);
  static final Color blueColor = Color(0xff58A4B0);
  static final Color darkGreyColor = Color(0xff373F51);
  static final Color whiteColorAlt = Color(0xffD8DBE2);

  static final TextStyle inriaSans18dim = GoogleFonts.inriaSans(
      fontSize: 18,
      fontStyle: FontStyle.italic,
      color: Colors.grey
  );
}
class InriaSansStyle{
  Color color;
  FontStyle fontStyle;
  FontWeight fontWeight;
  double size;
  List<Shadow> shadow;
  InriaSansStyle({this.fontWeight,this.color, this.fontStyle, this.size,this.shadow});
  get(){
    if (color == null){
      this.color = Colors.black;
    }
    if (size == null){
      this.size = 15;
    }
    return GoogleFonts.inriaSans(
      fontSize: size,
      fontStyle: fontStyle,
      fontWeight: fontWeight,
      color: color,
      shadows: shadow
    );
  }
}