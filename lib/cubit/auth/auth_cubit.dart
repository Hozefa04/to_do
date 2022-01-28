import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:to_do/cubit/auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {

  AuthCubit() : super(const AuthState(isSignedIn: false)) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        emit(copyWith(isSignedIn: false));
      } else {
        emit(copyWith(isSignedIn: true));
      }
    });
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //Login
  Future<void> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential).then((value) {
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  //Logout
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  String getUserId() {
    if(_firebaseAuth.currentUser != null) {
      return _firebaseAuth.currentUser!.uid;
    } else {
      return "";
    }
  }

}