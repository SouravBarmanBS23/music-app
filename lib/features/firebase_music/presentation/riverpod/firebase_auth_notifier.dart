part of './firebase_auth_provider.dart';

class FirebaseAuthNotifier extends Notifier<FirebaseAuthState> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();


  @override
  FirebaseAuthState build() {
    return FirebaseAuthState(
      isSigning: false,
    );
  }

  Future<void> handleSignIn() async {
    try{
      final googleUser = await _googleSignIn.signIn();
      if(googleUser != null){
        final googleAuth = await googleUser.authentication;
       final AuthCredential credential =  GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await _auth.signInWithCredential(credential);
        state = FirebaseAuthState(
          isSigning: true,
        );
      }else{
        state = FirebaseAuthState(
          isSigning: false,
        );
      }
    }catch(e){
      print('Error $e');
    }
  }

  Future<void> checkAlreadySignIn() async{
    final user = _auth.currentUser;
    if(user != null){
      state = FirebaseAuthState(
        isSigning: true,
      );
    }else{
       await handleSignIn();
    }
  }




}
