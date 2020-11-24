import 'package:bluespot/pages/mainPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:bluespot/pages/googleAuthentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage>{
  String email;   //추후에 아뒤 비번을 내가 생성할때 필요한 변수들 3개.
  String password;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  //아뒤 비번 직접생성시 필요한 함수. 나중에 창 만들고 onPressed: login, ㄱㄱ
  void login() {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      signin(email, password, context).then((value) {
        if (value != null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage(uid: value.uid),
              ));
        }
      });
    }
  }

getCurrentUser() {
    final auth = FirebaseAuth.instance.currentUser;
    return auth;
  }

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
              ),
              Padding(
                padding: EdgeInsets.only(left:30, right:30, top:20),
                child: SizedBox(
                    width: double.infinity,
                    child:ButtonTheme(
                      child:RaisedButton(
                          onPressed: () => googleSignIn().whenComplete(()async{
                            //main 건내줄 uid가 필요하다. 그래서 firebaseAuth함수를 사용.
                            User user = await FirebaseAuth.instance.currentUser;
                            //디비에 user data 입력.
                            //로그인을 누르면 로그인과 동시에 디비에 userData생성.
                            await FirebaseFirestore.instance.collection('UserData').doc(user.uid).set(
                              {
                                'name': user.displayName,
                                'email': user.email,
                                'uid': user.uid,
                                'profile_pic': user.photoURL,
                              }
                            );
                            //uid를 건내줘야 하니까 밑에 함수를 이용.
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainPage(uid: user.uid, loggeduser: getCurrentUser(),)));
                          }),
                          padding: EdgeInsets.all(20),
                          color: Colors.white,
                          child: Row(
                            children:[
                                Image.asset('lib/images/google1.jpg',width: 28,height:36),

                              RichText(
                                  text: TextSpan(
                                      text: '             Google Login',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.blue
                                      )
                                  )
                              )
                            ]
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