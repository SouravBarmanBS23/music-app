part of './firebase_auth_provider.dart';

class FirebaseAuthState {
  FirebaseAuthState({
    required this.isSigning,
    required this.isSignout,
  });

  final bool isSigning;
  final bool isSignout;

  FirebaseAuthState copyWith({
    bool? isSigning,
    bool? isSignout,
  }) {
    return FirebaseAuthState(
      isSigning: isSigning ?? this.isSigning,
      isSignout: isSignout ?? this.isSignout,
    );
  }
}
