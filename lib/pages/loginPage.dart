import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Padding(
                padding: EdgeInsets.only(
                  left:30,
                  right:30,
                  top: 20
                ),
                child:Image.asset(
                  "lib/images/BlueSpot.png",
                  width:170
                )
              ),
              Padding(
                padding: EdgeInsets.only(
                  left:30, right:30, top:20
                ),
                child:TextFormField(
                  decoration: new InputDecoration(
                    hintText: 'ID'
                  ),
                )
              ),
              Padding(
                padding: EdgeInsets.only(
                  left:30, right:30, top:20
                ),
                child: TextFormField(
                  decoration: new InputDecoration(
                    hintText: 'Password'
                  ),
                  obscureText: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left:30, right:30, top:20),
                child: SizedBox(
                  width: double.infinity,
                  child:ButtonTheme(
                    child:RaisedButton(
                      onPressed: () async{
                        showDialog(context: context,
                          builder: (BuildContext context){
                          return Center(child: CircularProgressIndicator());
                          }
                        );
                        await loginAction();
                        Navigator.pushNamed(context, '/AfterLogin');
                      },
                      padding: EdgeInsets.all(20),
                      color: Colors.blue,
                      child: RichText(
                        text: TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            fontSize: 20
                          )
                        )
                      )
                    ),
                    height: 42,
                  )
                ),
              )
            ]
          )
        )
      )
    );
  }
  Future<bool> loginAction() async{
    await new Future.delayed(const Duration(seconds:2));
    return true;
  }
}