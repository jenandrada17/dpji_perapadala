import 'package:dpji_perapadala/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<MainPage> {

  _loadInitialMessages() async {
    print('Something');
  }

  @override
  void initState() {
    _loadInitialMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final username = context.watch<AuthService>().getUserName();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Hi $username'),
        actions: [
          IconButton(
              onPressed: (){
                context.read<AuthService>().logoutUser();
                // Navigator.pop(context);  //Go to previous page
                // Navigator.maybePop(context);  //Dont close if it is the only screen (stay on screen)
                // Navigator.pushNamed(context, '/');
                // Navigator.popAndPushNamed(context, '/');
                Navigator.pushReplacementNamed(context, '/');
                print('Icon pressed!');
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0), // Add padding as needed
            color: Colors.red, // Set background color as needed
            child: const Text(
              '  Main Page  ',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.normal, letterSpacing: 0.1, fontFamily: 'Arial'
              ),
            ),
          ),
        ],
      ),
    );
  }
}
