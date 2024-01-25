import 'package:dpji_perapadala/services/auth_service.dart';
import 'package:dpji_perapadala/utils/spaces.dart';
import 'package:dpji_perapadala/widgets/login_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_buttons/social_media_button.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formkey = GlobalKey<FormState>();

  Future<void> loginUser(BuildContext context) async {
    if(_formkey.currentState!=null && _formkey.currentState!.validate()){
      print(userNameController.text);
      print(passwordController.text);

      await context.read<AuthService>().loginUser(userNameController.text);

      // Navigator.pushNamed(context, '/chat', arguments: '${userNameController.text}');
      Navigator.pushReplacementNamed(context, '/chat', arguments: '${userNameController.text}');
      print('Login Successful!');
    }else{
      print('Login Unuccessful!');
    }
  }

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final Uri toLaunch = Uri(scheme: 'https', host: 'www.google.com');

  Widget _buildHeader(context){
    return Column(
      children: [
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: const DecorationImage(
                // fit: BoxFit.fitWidth,
                  image: AssetImage('assets/dalton-logo.png')),
              borderRadius: BorderRadius.circular(24)),
        ),
        // verticalSpacing(24),

        Container(
          padding: EdgeInsets.all(10.0), // Add padding as needed
          color: Colors.red, // Set background color as needed
          child: const Text(
            '  PERA PADALA ONLINE  ',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.normal, letterSpacing: 0.1, fontFamily: 'Arial'
            ),
          ),
        ),

        verticalSpacing(30),
      ],
    );
  }

  Widget _buildForm(context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Form(
            key: _formkey,
            child: Column(
              children: [
                LoginTextField(
                  hintText: "Enter your username",
                  validator: (value){
                    if (value != null && value.isNotEmpty && value.length < 5){
                      return "Your username should be more than 5 characters";
                    }else if(value != null && value.isEmpty){
                      return  "Please type your username";
                    }
                    return  null;
                  },
                  controller: userNameController,
                ),

                verticalSpacing(24),

                LoginTextField(
                  hasAsterisks: true,
                  controller: passwordController,
                  hintText: "Enter your password",
                ),
              ],
            )
        ),
        verticalSpacing(24),
        ElevatedButton(
            onPressed: () async {
              await loginUser(context);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.blue, // Change the background color here
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 8), // Adjust padding here
            ),
            child: const Text(
              'Login',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.black),
            )
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: LayoutBuilder(
              builder: (context, BoxConstraints constraints) {
                if(constraints.maxWidth > 1000) {
                  //web layout
                  return Row(
                    children: [
                      Spacer(flex: 1),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildHeader(context),
                          ],
                        ),
                      ),
                      Spacer(flex: 1),
                      Expanded(child: _buildForm(context)),
                      Spacer(flex: 1),
                    ],
                  );
                }

                return Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeader(context),
                    _buildForm(context),
                  ],
                );
              }
          ),
        ),
      ),
    );
  }
}