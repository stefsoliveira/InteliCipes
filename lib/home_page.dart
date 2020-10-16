import 'package:flutter/material.dart';
import 'package:projeto_3/widgets.dart';
import 'package:projeto_3/assets_handler.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Assets.whiteColor,
        body: Column(
          children: [
            Hero(
              tag: 'intelibar',
              child: Material(
                color: Colors.transparent,
                child: InteliBar(
                  color: Assets.blueColor,
                  leftIcon: Icons.menu,
                  rightIcon: Icons.more_vert,
                  rightPath: '/settings',
                ),
              ),
            ),
            Assets.smallPaddingBox,
            Hero(
                tag: 'searchbar',
                child: Material(
                  color: Colors.transparent,
                  child:
                    SearchBar(
                      colorIcon:Assets.whiteColor,
                      colorMain: Assets.darkGreyColor,
                      path: '/food_display',
                      action: 'modal',
                      isForm: false
                    ),
                )
            ),
            Assets.smallPaddingBox,
            Row(
              children: [
                Assets.smallPaddingBox,
                TextBar(
                  texto: "Categorias",
                  theme: 'dark',
                  size: 15,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4,left: 8,right: 8,bottom: 8),
              child: ColectionBar(),
            ),//ColectionBar
            RecommendedDisplay(),
          ],
        ),
      ),
    );
  }
}
