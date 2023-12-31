import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        clientId:
            '191251944607-1fnl9eeloo9og88lb22apubrc8nt3ofe.apps.googleusercontent.com',
      );

      final GoogleSignInAccount? gUser = await _googleSignIn.signIn();

      if (gUser == null) {
        // User canceled the sign-in
        return null;
      }

      final GoogleSignInAuthentication gAuth = await gUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print('Error during Google sign-in: $e');
      return null;
    }
  }
}
