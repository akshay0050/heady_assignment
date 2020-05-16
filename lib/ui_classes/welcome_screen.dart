import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heady_assignement/style/Style.dart';
import 'package:heady_assignement/ui_classes/main_shop_page.dart';
import 'package:page_transition/page_transition.dart';



class WelcomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WelcomeScreenState();
  }
}

class _WelcomeScreenState extends State<WelcomeScreen>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => navigateToNextPage());
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
    Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/images/img_heady_logo.png",
                  height: 400.0,
                  width: 400.0,
                ),
                Text(
                  "Welcome to the Heady",
                  style: Style.welcomeText,
                ),

              ],
            )

      ),
    );
  }

  void navigateToNextPage(){
    // thread delayed for 3 sec
    Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.pushReplacement(context,
          PageTransition(
            child: MainShopPage(),
            type: PageTransitionType.rightToLeft,
            duration: Duration(milliseconds: 1000),
          ));
    });
  }
}