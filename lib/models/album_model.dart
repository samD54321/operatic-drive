import 'package:music_app_ui/models/song_model.dart';

class AlbumModel {
  num id;
  String name;
  final List<SongModel> songs;
  AlbumModel({
    required this.id,
    required this.name,
    required this.songs,
  });
}
