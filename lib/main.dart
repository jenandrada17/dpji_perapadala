import 'package:dpji_perapadala/main_page.dart';
import 'package:dpji_perapadala/utils/brand_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dpji_perapadala/services/auth_service.dart';

import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.init();
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => AuthService(),
      child: DPJI_App()));
}

class DPJI_App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chat App!!",
      theme: ThemeData(
          canvasColor: Colors.transparent,
          primaryColor: BrandColor.primaryColor,
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.black)), // Change primaryColor to the desired color
      home: FutureBuilder<bool>(
        future: context.read<AuthService>().isLoggedIn(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasData && snapshot.data!){
              return MainPage();
            }else return LoginPage();
          }
          return CircularProgressIndicator();
        },
      ),

      // home: LoginPage(),
      routes: {'/mainpage': (context) => MainPage()},
      // home: ChatPage(),
    );
  }
}
