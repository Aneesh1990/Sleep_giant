import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


/***
 * UserRepository which will be responsible for abstracting the underlying
 * implementation for how we authenticate and retrieve user information.
 ***/
///
class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  //<editor-fold desc=" Method :- signInWithGoogle">

  ///This Method used to authenticate the user using the [GoogleSignIn] package.

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser();
  }

  //</editor-fold>

  //<editor-fold desc=" Method :- signInWithCredentials">

  ///This method which will allow users to sign in with their own credentials using [FirebaseAuth].

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  //</editor-fold>

  //<editor-fold desc=" Method :- signUp">

  ///This method which allows users to create an account if they choose not to use Google Sign In.

  Future<void> signUp({String email, String password}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
  //</editor-fold>

  //<editor-fold desc=" Method :- signOut">

  ///This method so that we can give users the option to logout and clear their profile information from the device..

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  //</editor-fold>

  //<editor-fold desc=" Method :- isSignedIn">

  ///This method to check if a user is already authenticated.

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  //</editor-fold>

  //<editor-fold desc=" Method :- getUser">

  /*** It is only returning the current user's email address for the sake of
   *   simplicity but we can define our own User model and populate it with 
   *  a lot more information about the user
   */

  /// This method used if a user is already authenticated then to retrieve their information.

  Future<String> getUser() async {
    return (await _firebaseAuth.currentUser()).email;
  }
  //</editor-fold>
}
