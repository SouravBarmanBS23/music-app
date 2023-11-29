class MusicModel {
  MusicModel({
    required this.id,
    required this.uri,
    required this.displayName,
    required this.displayNameWOExt,
  });
  int id;
  String? uri;
  String displayName;
  String? displayNameWOExt;

  static List<MusicModel> musicModelList = [];
}
