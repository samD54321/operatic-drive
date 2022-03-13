import 'package:music_app_ui/res/assets.dart';

class SongModel {
  int id = 0;
  final String album;
  final String image;
  final String year;
  final String title;
  final String path;
  String artist = 'Water Melon';
  num arousal = 0;
  num valence = 0;
  String emotionTag = ' ';

  SongModel(
      {required this.id,
      required this.album,
      required this.image,
      required this.year,
      required this.title,
      required this.path,
      required this.arousal,
      required this.valence,
      required this.emotionTag,
      artist});

  static SongModel instance() {
    return SongModel(
        id: -1,
        album: '',
        image: Assets.SONG,
        year: '',
        title: '',
        path: '',
        arousal: 0,
        valence: 0,
        emotionTag: '');
  }
}
