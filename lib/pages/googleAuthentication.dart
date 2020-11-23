//밑에 2개 라이브러리 필요.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:bluespot/pages/mainPage.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final GSignIn = GoogleSignIn(); //구글 로그인 함수.


// a simple sialog to be visible everytime some error occurs
showErrDialog(BuildContext context, String err) {
  // to hide the keyboard, if it is still p
  FocusScope.of(context).requestFocus(new FocusNode());
  return showDialog(
    context: context,
    child: AlertDialog(
      title: Text("Error"),
      content: Text(err),
      actions: <Widget>[
        OutlineButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("굳"),
        ),
      ],
    ),
  );
}

//원래 bool이였음
Future<bool> googleSignIn() async {
  //함수. await googleSignIn.signIn()이게 있어야 구글 로그인이 가능하다. 이거 때문에 asynchronous함수가 됨.
  GoogleSignInAccount googleSignInAccount = await GSignIn.signIn();

  //구글 로그인이 오류가 났을때 대처하는 에러처리.
  if (googleSignInAccount != null) {
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication; //이게 데이터를 줌.

    //firebase credential. id token, access token을 가져다 준다.
    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    //위의 모든게 됐다면 firebase auth를 불러서 signin을 해야하기 때문에 필요한 함수.
   //AuthResult 가 UserCredential로 업데이트 됨...
    UserCredential result = await auth.signInWithCredential(credential);

    //현재 로그인된 유저를 불러온다. 지금 가능한 로그인된 유저를 불러온다.
    //FirebaseUser가 User로 업데이트 됨...
    User user = await auth.currentUser;

    //콘솔 디버깅용.
    print(user.uid);
    //print(await getCurrentUser());
    print(await getCurrentUID());

    //나중에 발생하는 오류에 대해서 에러처리를X
    return Future.value(true);
    //return user;
  }
}

/*
Future <User> login() async{
  await GSignIn.signIn();
  User user= new User(
    email: GSignIn.currentUser.email,
    name: GSignIn.currentUser.displayName,
    profilePic: GSignIn.currentUser.photoUrl,
  );
  return User;
}*/

//future 찾아보기.
//밑에서 생성한 이메일, 비번을 가지고 로그인하는 방법.
Future <User> signin(
    String email, String password, BuildContext context) async {
  //에러가 발생했을때 처리.
  try {
    UserCredential result =
    //이메일, 비번을 가지고 로그인을 시켜준다.
    await auth.signInWithEmailAndPassword(email: email, password: email);
    User user = result.user;
    // return Future.value(true);
    return Future.value(user);
  } catch (e) {
    // simply passing error code as a message
    print(e.code);
    switch (e.code) {
      case '이메일오류':
        showErrDialog(context, e.code);
        break;
      case '비번오류':
        showErrDialog(context, e.code);
        break;
    }
    return Future.value(null);
  }
}

//이부분이 email, password를 이용해서 로그인 시켜주는거.
Future<User> signUp(
    String email, String password, BuildContext context) async {
  try {
    //유저를 생성해주는 함수.
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email, password: email);
    //위에서 유저를 생성했으니까 유저를 찾을때 쓰는 함수?
    User user = result.user;
    return Future.value(user);
    // return Future.value(true);  이게 에러를 출력할 수 있다.
  } catch (error) {
    //에러가 났을때 어떤 오류가 났는지 확인시켜준다.
    switch (error.code) {
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        showErrDialog(context, "Email Already Exists");
        break;
      case 'ERROR_INVALID_EMAIL':
        showErrDialog(context, "Invalid Email Address");
        break;
      case 'ERROR_WEAK_PASSWORD':
        showErrDialog(context, "Please Choose a stronger password");
        break;
    }
    return Future.value(null);
  }
}

/*
로그아웃할때 필요한 함수.
구글을 통해 로그인을 했던, 이메일, 비밀번호를 이용해서 로그인을 했던 나가는 방식은 같아야 한다.
즉 이 함수 하나로 2개를 구분하지 않고 로그아웃을 시켜줘야 한다.
 */

/*
Future<bool> signOutUser() async {
  //현재 유저 정보를 얻어온다.
  User user = await auth.currentUser;

  //유저의 속상을 확인한다. 구글은 이 방법을 사용하고 페북은 provideData대신에 다른 방법이 있는듯?
  print(user.providerData[1].providerId);
  //밑에 if문을 통해서 유저가 비밀번호와 아이디를 치고 들어왔는지 아니면 구글로그인을 통해서 들어왔는지 확인을 하고 알맞는 방법으로 로그아웃을 시켜준다.
  //만약에 구글을 통해서 로그인을 했다면 if문 안으로 들어간다.
  if (user.providerData[1].providerId == 'google.com') {
    await GSignIn.signOut();
    /*signout과 disconnect 함수의 다른점.
      singout: 이걸 통해서 나가고 난 후에 다시 로그인을 하려고 한다면 이전에 로그인을 했던 구글 메일로 자동으로 로그인 시켜준다.
      disconnect: 이걸 통해서 나가고 다시 구글 로그인을 하려고 한다면 그때 어떤 계정으로 로그인을 할꺼냐고 물어본다.
     */

  }else await auth.signOut(); //이메일과 비번을 직접 생성해서 만들었다면 이거 하나로 로그아웃이 가능하다.
  return Future.value(true);
}
*/

Future <void> signOutUser() async{
  await auth.signOut(); //firebase에서도 나가는거
  await GSignIn.signOut();  //구글에서 나가는거.
}

//uid 받기
Future <String> getCurrentUID() async{
  return auth.currentUser.uid;
}

//current user
/*
Future getCurrentUser() async{
  return auth.currentUser;
}*/

getProfileImage(){
  if(auth.currentUser.photoURL!=null){
    return Image.network(auth.currentUser.photoURL);
  }else{
    return Icon(Icons.account_circle);
  }
}

