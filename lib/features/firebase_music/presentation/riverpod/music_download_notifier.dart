
part of './music_dowload_provider.dart';

class MusicDownloadNotifier extends Notifier<BaseState> {

  final List<int> downloadItems = [];

  @override
  BaseState build() {
   return BaseState(data: []);
  }

  void addItem(int index){
    downloadItems.add(index);

  }

  void cacheMusicName(String musicName) {
     print('cache music name called :$musicName ');
    final box = Hive.box<String>('cloud-download');
    if(box.isOpen){
      print('hive is open');
      if(!box.containsKey(musicName)){
        print('name stored to hive');
        box.put(musicName, musicName);
      }
     // box.close();
    }
  }
}
