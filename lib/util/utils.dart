import 'dart:math';

import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:music_app_ui/models/album_model.dart';
import 'package:music_app_ui/models/song_model.dart';
import 'package:audiotagger/audiotagger.dart';
import 'package:music_app_ui/res/assets.dart';

final FlutterAudioQuery audioQuery = FlutterAudioQuery();
final tagger = Audiotagger();
MusicFinder audioPlayer = MusicFinder();
List<String> allSongs = [''];
List<SongInfo> songinfos = [];

List<String> categories = [
  "All",
  "Anxious",
  "Miserable",
  "Nervous",
  "Encouraged",
  'Upset',
  'Joyful',
  'Loving'
];
List<Color> colors = [
  Color.fromARGB(228, 144, 145, 140),
  Color.fromARGB(242, 38, 233, 71),
  Color.fromARGB(255, 54, 232, 245),
  Color.fromARGB(237, 51, 243, 60),
  Color.fromARGB(242, 240, 221, 54),
  Color.fromARGB(251, 204, 217, 233),
  Color.fromARGB(235, 12, 248, 138),
  Color.fromARGB(255, 241, 8, 66),
];

class PlayerState {
  static const PLAYING = 1;
  static const PAUSED = 2;
  static const STOPPED = 3;
  static Duration songLength = Duration(seconds: 1);
  static Duration position = Duration();
  static SongModel currentSong = SongModel.instance();
  static AlbumModel currentAlbum = AlbumModel(id: 0, name: 'name', songs: []);
}

class Utils {
  static dynamic navBarState = (f) {};
  static dynamic playerSetState = (f) {};
  static dynamic playListState = (f) {};
  static dynamic playingState = (f) {};

  static dynamic homeState = (f) {};
  static dynamic searchState = (f) {};
  static dynamic searchResState = (f) {};
  static dynamic bmState = (f) {};

  static int playerState = PlayerState.STOPPED;
  static var songLength = 0;
  static var duration = 0;
  static String serverLink = '';
  static Color color = colors[0];

  static setState(f) {
    navBarState(f);
    playListState(f);
    playerSetState(f);
    playingState(f);
    searchState(f);
    searchResState(f);
    bmState(f);
    homeState(f);
  }

  static Future<List<String>> getSongs() async {
    List<String> ret = [];
    List<SongInfo> songs = await audioQuery.getSongs();
    songinfos = songs;
    ret = songs.map((SongInfo s) {
      return s.filePath;
    }).toList();
    allSongs = ret;
    return ret;
  }

// add a isLocal parameter to play a local file
  static play({song, url}) async {
    // ignore: prefer_function_declarations_over_variables
    var task_ = (song) {
      print(song.path);
      audioPlayer.play(song.path, isLocal: true).then((result) {
        PlayerState.currentSong = song;
        setState(() => Utils.playerState = PlayerState.PLAYING);
      });
    };

    if (url == null && song == null) {
      if (PlayerState.currentSong.id != -1) {
        task_(PlayerState.currentSong);
      }
    } else {
      url ??= song.path;
      urlToSong(url).then((song) {
        task_(song);
      });
    }
  }

  static pause() async {
    audioPlayer.pause().then((v) {
      setState(() => Utils.playerState = PlayerState.PAUSED);
    }).catchError((e) {
      Utils.playerState = PlayerState.STOPPED;
    });
  }

  static stop() async {
    if (playerState != PlayerState.STOPPED) {
      audioPlayer.stop().then((v) {
        setState(() => Utils.playerState = PlayerState.STOPPED);
      });
    }
  }

  static next() async {
    int id = PlayerState.currentSong.id;
    int songsNo = PlayerState.currentAlbum.songs.length;
    int next = id + 1;
    print(songsNo);
    print(next);
    if (next > songsNo) {
      next = 0;
    }
    stop();
    PlayerState.currentSong = PlayerState.currentAlbum.songs[next];
    play();
    setState(() {});
  }

  static previous() async {
    int id = PlayerState.currentSong.id;
    int songsNo = PlayerState.currentAlbum.songs.length;
    int prev = id - 1;
    if (prev < 0) {
      prev = songsNo - 1;
    }
    stop();
    PlayerState.currentSong = PlayerState.currentAlbum.songs[prev];
    play(song: PlayerState.currentAlbum.songs[prev]);
  }

  static Future<SongModel> urlToSong(url, {i = 0}) async {
    // Map? map = await tagger.readTagsAsMap(path: url);
    final Map? map = {'path': url};
    SongInfo info = songinfos.firstWhere((element) => element.filePath == url);

    for (String tag in [
      'album',
      'title',
      'year',
      'artwork',
      'path',
      'arousal',
      'valence',
      'emotionTag'
    ]) {
      switch (tag) {
        case 'arousal':
          map?.update(tag, (v) => v, ifAbsent: () => 0.0);
          break;
        case 'valence':
          map?.update(tag, (v) => v, ifAbsent: () => 0.0);
          break;
        case 'path':
          map?.update(tag, (v) => v, ifAbsent: () => url);
          break;
        case 'artwork':
          map?.update(tag, (v) => v, ifAbsent: () => Assets.SONG);
          break;
        default:
          map?.update(tag, (val) => val, ifAbsent: () => 'NA');
          break;
      }
    }

    return SongModel(
        id: i,
        album: info.album,
        title: info.title,
        year: info.year,
        image: map?['artwork'],
        path: url,
        arousal: map?['arousal'],
        valence: map?['valence'],
        emotionTag: map?['emotionTag']);
  }

  static Future<AlbumModel> setUpTempAl(url) async {
    SongModel model = await urlToSong(url);
    return AlbumModel(id: 0, name: 'Temp', songs: [model]);
  }

  static Future<AlbumModel> urlsToAlbumn(urls, name) async {
    List<SongModel> songs = [];
    int i = 0;
    for (String url in urls) {
      try {
        SongModel song = await urlToSong(url, i: i);
        songs.add(song);
        i++;
      } on Exception {
        continue;
      }
    }
    return AlbumModel(id: 0, name: name, songs: songs);
  }

  static setupAlbumns(category) async {
    int chunks = (allSongs.length / (categories.length - 1)).round();
    List<SongModel> songs = [];
    for (int i = 0; i < chunks; i++) {
      songs.add(
          await urlToSong(allSongs[Random().nextInt(allSongs.length - 1)]));
    }
    PlayerState.currentAlbum = AlbumModel(id: 0, name: category, songs: songs);
    PlayerState.currentSong = PlayerState.currentAlbum.songs[0];
    print(PlayerState.currentAlbum.songs.length);
    Utils.setState(() {});
  }

  static initPlayer() async {
    audioPlayer.setDurationHandler((duration) {
      Utils.setState(() {
        PlayerState.songLength = duration;
        print("Setting duration ${PlayerState.songLength.inSeconds}");
      });
    });
    audioPlayer.setCompletionHandler(() {
      next();
    });
    audioPlayer.setPositionHandler((position) {
      Utils.setState(() {
        PlayerState.position = position;

        print(position.inSeconds);
        // print(PlayerState.currentAlbum.songs.length);
        // print(PlayerState.songLength.inSeconds);
        print(PlayerState.position.inSeconds);
      });
    });

    await Utils.getSongs().then((v) {
      urlsToAlbumn(v, 'Operatic Drive').then((albumn) {
        PlayerState.currentAlbum = albumn;
        PlayerState.currentSong = albumn.songs[0];
        print(PlayerState.currentAlbum.songs.length);
      });
    });
  }
}
