import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heady_assignement/bloc/product_data_bloc.dart';
import 'package:heady_assignement/data/product_data_repository.dart';
import 'package:heady_assignement/network_calls/env.dart';
import 'package:heady_assignement/ui_classes/main_shop_page.dart';
import 'package:heady_assignement/ui_classes/welcome_screen.dart';

import 'data/fetch_product_data.dart';

void main() {
  Env.setEnvironment(Environment.PROD);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Heady Assignment',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home:
            BlocProvider(
              create: (context) => ProductDataBloc(FetchProductData()),
              child: WelcomeScreen(),
            )

       // WelcomeScreen()
    );
  }
}
