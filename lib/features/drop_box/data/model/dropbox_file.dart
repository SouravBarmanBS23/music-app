class DropboxFile {

  DropboxFile({
    required this.pathDisplay,
    required this.name,
    required this.isDownloaded,

  });
  final String pathDisplay;
  final String name;
  bool isDownloaded = false;

  // mane a copyWith method
  DropboxFile copyWith({
    String? pathDisplay,
    String? name,
    bool? isDownloaded,
  }) {
    return DropboxFile(
      pathDisplay: this.pathDisplay,
      name: this.name,
      isDownloaded: isDownloaded ?? this.isDownloaded,
    );
  }

}
