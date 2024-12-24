import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  ///UserCredential -> an object that is returned after successful authentication

  ///_authenticate is a wrapper method. it is triggered when explicitly called in code
  Future<User?> _authenticate(
      Future<UserCredential> Function() authMethod) async {
    try {
      final credentials = await authMethod();

      /// .user -> creates user information returned bu authMethod
      return credentials.user;
    } on FirebaseAuthException catch (e) {
      throw e;
    } catch (e) {
      print("Unknown error: $e");
      rethrow;
    }
  }

  Future<User?> createUserWithEmailAndpassword(
      String email, String password) async {
    return _authenticate(() =>
        _auth.createUserWithEmailAndPassword(email: email, password: password));
  }

  Future<User?> loginUserWithEmailAndpassword(
      String email, String password) async {
    return _authenticate(() =>
        _auth.signInWithEmailAndPassword(email: email, password: password));
  }

  Future<UserCredential?> loginWithGoogle() async {
    try {
      await _auth.signOut();
      await GoogleSignIn().signOut();
      final googleUser = await GoogleSignIn().signIn();
      print('googleUser $googleUser');
      if (googleUser == null) {
        return null;
      }
      final googleAuth = await googleUser.authentication;
      final googleCred = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      print(googleCred);
      return await _auth.signInWithCredential(googleCred);
    } catch (e) {
      print('error occured ${e.toString()}');
    }
    return null;
  }

  Future<void> signout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('An error occured: $e');
    }
  }

  Future<void> sendEmailVerificationLink() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } catch (e) {
      print(e.toString());
    }
  }

}
