class UserModel {
  UserModel({
    required this.displayName,
    required this.email,
    required this.homeNamespaceId,
    required this.country,
  });

  final String? displayName;
  final String? email;
  final String? homeNamespaceId;
  final String? country;
}
