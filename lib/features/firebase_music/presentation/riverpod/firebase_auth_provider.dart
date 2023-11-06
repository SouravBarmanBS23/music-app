import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

part './firebase_auth_notifier.dart';
part './firebase_auth_state.dart';

final firebaseAuthProvider =
    NotifierProvider<FirebaseAuthNotifier, FirebaseAuthState>(
  FirebaseAuthNotifier.new,
);
