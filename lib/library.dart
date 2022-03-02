import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:operatic_drive/player.dart';
import 'package:operatic_drive/utils/RouteGenerator.dart';


class MyLibrary extends StatefulWidget {
  @override
  _MyLibraryState createState() => _MyLibraryState();
}

class _MyLibraryState extends State<MyLibrary> {
  List<List<dynamic>> _songs = [];

  void decodeCSV() async {
    final _rawData =
        await rootBundle.loadString("assets/annotations/songs_info.csv");

    List<List<dynamic>> songs = CsvToListConverter(
            fieldDelimiter: ',', textDelimiter: '****', eol: '\n')
        .convert(_rawData);
    songs.removeAt(0);
    setState(() {
      _songs = songs;
    });
  }

  @override
  Widget build(BuildContext context) {
    decodeCSV();

    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.transparent),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _songs.length,
        itemBuilder: (context, index) {
          String singer = _songs[index][2].toString().replaceAll('\t', '').replaceAll('\"', '');
          String song = _songs[index][3].toString().replaceAll('\t', '').replaceAll('\"', '');
          String song_path = _songs[index][1].toString().replaceAll('\t', '').replaceAll('\"', '');
          return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                    context, RouteGenerator.MUSIC_PLAYER,
                    arguments: [song_path]);
              },
              child: Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom:10),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.transparent,
                            blurRadius: 0.5,
                            offset: Offset(4, 8), // Shadow position
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(

                              child: Padding(
                                padding: EdgeInsets.all(2.0),
                                child: CircleAvatar(
                                  radius: 30.0,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: AssetImage('assets/a.jpg'),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  (song.length<30)?song:song.substring(0,30)+"...",
                                  style: TextStyle(
                                    color: const Color(0xFFffffff),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                    (singer.length<45)?singer:singer.substring(0,45 )+"...",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                     Divider(
                      height: 10,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                      color: Colors.grey,
                    ),
                  ],
                ),
              )
          );
        },
      ),
    );
  }
}
