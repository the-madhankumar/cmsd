import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthService {
  signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn(
        clientId:
            '191251944607-1fnl9eeloo9og88lb22apubrc8nt3ofe.apps.googleusercontent.com');
    final GoogleSignInAccount? gUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential?> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.status == LoginStatus.success) {
        if (loginResult.accessToken != null) {
          final OAuthCredential facebookAuthCredential =
              FacebookAuthProvider.credential(loginResult.accessToken!.token);

          return await FirebaseAuth.instance
              .signInWithCredential(facebookAuthCredential);
        } else {
          print('Facebook access token is null');
          return null;
        }
      } else {
        print(
            'Facebook login failed. Status: ${loginResult.status}, message: ${loginResult.message}');
        return null;
      }
    } catch (e) {
      print('Error during Facebook sign-in: $e');
      return null;
    }
  }
}
