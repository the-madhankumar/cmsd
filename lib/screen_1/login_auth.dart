import 'package:flutter/material.dart';
import 'package:cmsd_home/screen_1/login_signup.dart';
import 'package:cmsd_home/home_g.dart';
import 'package:firebase_auth/firebase_auth.dart';

@override
class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return HomePage_1();
          }else{
            return const LoginSignupScreen();
          }
        },
      ),
    );
  }
}

@override
class SignOut extends StatelessWidget {
  const SignOut({super.key});
  
  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
    print("out");
  }

  @override
  Widget build(BuildContext context) {
    signUserOut();
    return const LoginSignupScreen();
  }
}