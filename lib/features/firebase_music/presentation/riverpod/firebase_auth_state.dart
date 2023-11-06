part of './firebase_auth_provider.dart';

class FirebaseAuthState {
  FirebaseAuthState({
    required this.isSigning,
  });

  final bool isSigning;

  FirebaseAuthState copyWith({
    bool? isSigning,
  }) {
    return FirebaseAuthState(
      isSigning: isSigning ?? this.isSigning,
    );
  }
}
