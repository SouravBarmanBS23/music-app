import 'package:firebase_storage/firebase_storage.dart';

class FirebaseMusicModel {
  FirebaseMusicModel({
    required this.name,
    required this.getDownloadUrl,
    required this.reference,
    required this.isSelected,
  });

  String? name;
  String? getDownloadUrl;
  Reference reference;
  bool isSelected = false;

  FirebaseMusicModel copyWith({
    String? name,
    String? getDownloadUrl,
    bool? isSelected,
    Reference? reference,
  }) {
    return FirebaseMusicModel(
      name: this.name,
      getDownloadUrl: this.getDownloadUrl,
      reference: this.reference,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
