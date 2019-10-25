import 'package:flutter/material.dart';
import 'ui/home.dart';
import 'ui/LoginScreen.dart';
import 'package:flutter/services.dart';
import 'helper/login_helper.dart';
import 'helper/Api.dart';

void main() async{
  LoginHelper helper = LoginHelper();

  Logado logado = await helper.getLogado();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  runApp(
      MaterialApp(
      home: (logado != null)?HomePage(logado.id,Api(token: logado.logadoToken)):LoginScreen(),
      debugShowCheckedModeBanner: false,
    ));


}


