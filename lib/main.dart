import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void  main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      
    );
  }
}

class HomePage extends StatelessWidget {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  Future<FirebaseUser> _signIn() async{
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: gSA.accessToken,
    idToken: gSA.idToken,
  );

  final FirebaseUser user = await _auth.signInWithCredential(credential);

  print("Signed In " + user.displayName);
  return user;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Demo'),
        centerTitle: true,
      ),
      body: new Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RaisedButton(
              onPressed: (){
                _signIn()
                .then((FirebaseUser user )=> print(user))
                .catchError((e)=> print(e));
                },
              child: Text('Login'),
              color: Colors.green,
            ),

            SizedBox(height: 10,),

            RaisedButton(
              onPressed: (){},
              child: Text('Sign out'),
              color: Colors.red,
            ),

          ],
        ),
      ),
    );
  }
}