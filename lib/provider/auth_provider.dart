import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class AuthProvider{

  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  /// Sign Out user
  Future<String> signOut()async{
    await _firebaseAuth.signOut();
    await GoogleSignIn(scopes: <String>['email']).signOut();

    return "Sign Out success";
  }

  /// Sign In
  Future<UserCredential> signInWithGoogle()async{
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser= await GoogleSignIn().signIn();

    //Obtain the the auth details from the request
    final GoogleSignInAuthentication? googleAuth= await googleUser?.authentication;

   // Create a new credential
    final credential=GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once sign in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}