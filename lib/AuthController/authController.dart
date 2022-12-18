import 'package:firebase_auth/firebase_auth.dart';
 
class AuthController {
  FirebaseAuth? firebaseAuth;
  AuthController() {
    firebaseAuth = FirebaseAuth.instance;
  }

  Future<void> logout() async {
    await firebaseAuth!.signOut();
  }

  String? get username => firebaseAuth!.currentUser!.displayName;
  String? get uid => firebaseAuth!.currentUser!.uid;
  Future<bool> checkSignIn() async {
    try {
      await firebaseAuth!.currentUser!.reload();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signUp(String usernasme, String email, String password) async {
    try {
      UserCredential user = await firebaseAuth!
          .createUserWithEmailAndPassword(email: email, password: password);
      user.user!.updateDisplayName(usernasme);
      return true;
    } catch (ee) {
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      UserCredential signInResponse = await firebaseAuth!
          .signInWithEmailAndPassword(email: email, password: password);

      String token = await signInResponse.user!.getIdToken();

      return true;
    } catch (ee) {
      return false;
    }
  }


}
