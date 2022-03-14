import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:music_app_ui/models/album_model.dart';
import 'package:music_app_ui/models/song_model.dart';
import 'package:music_app_ui/res/assets.dart';
import 'package:music_app_ui/util/navigation/navigation_service.dart';
import 'package:music_app_ui/util/navigation/routes.dart';
import 'package:music_app_ui/util/utils.dart';

class PlayListScreen extends StatefulWidget {
  final bool isCurrent;

  const PlayListScreen({Key? key, required this.isCurrent}) : super(key: key);

  @override
  _PlayListScreenState createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  NumberFormat formatter = NumberFormat("00");

  @override
  Widget build(BuildContext context) {
    Utils.playListState = setState;
    return Offstage(
      offstage: !widget.isCurrent,
      child: Scaffold(

        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              GetIt.I
                  .get<NavigationService>()
                  .clearAllTo(routeName: Routes.home);
            },
            child: SvgPicture.asset(
              Assets.BACK,
              height: 24,
              width: 24,
              color: Utils.color,
              // fit: BoxFit.fill,
            ),
          ),
          automaticallyImplyLeading: true,
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        body: Column(
          children: [
            // SizedBox(height: 8.h),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Utils.color,
              elevation: 3,
              margin: const EdgeInsets.all(10),
              child: Container(
                height: 127.r,
                padding: EdgeInsets.only(
                    left: 20.w, right: 20.w, top: 20.w, bottom: 20.w),
                child: Row(
                  children: [
                    Container(
                      // color: Colors.white,
                      width: 127.r,
                      height: 127.r,
                      margin: EdgeInsets.only(right: 14.w),
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        image: DecorationImage(
                          image: AssetImage(PlayerState.currentSong.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Album - ${PlayerState.currentAlbum.songs.length} songs - ${PlayerState.currentSong.year}",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: (14 - 5).sp,
                              color: Colors.white,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Text(
                          PlayerState.currentAlbum.name,
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: (24 - 5).sp,
                              color: Colors.white,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          'Mix Operatic Drive',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: (14 - 5).sp,
                              color: Colors.white,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.only(top: 17.h),
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: (c, i) {
                  return InkWell(
                    onTap: () {
                      Utils.setState(() {
                        Utils.stop();
                        PlayerState.currentSong = PlayerState.currentAlbum.songs
                            .firstWhere((element) => element.id == i);
                        Utils.play();
                      });
                      GetIt.I
                          .get<NavigationService>()
                          .to(routeName: Routes.playingNow);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 29.w, right: 34.w),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 22.w),
                            child: i == PlayerState.currentSong.id
                                ? Container(
                                    width: 32.2,
                                    height: 29.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      image: const DecorationImage(
                                        image: AssetImage(Assets.MISIC_LEVEL),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Text(
                                    formatter.format(i + 1),
                                    maxLines: 1,
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                        fontSize: (24 - 5).sp,
                                        color: Colors.white,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                PlayerState.currentAlbum.songs[i].title,
                                maxLines: 1,
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: (18 - 5).sp,
                                    color: Colors.white,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                PlayerState.currentAlbum.songs[i].artist,
                                maxLines: 1,
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: (14 - 5).sp,
                                    color: Colors.white,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              )
                            ],
                          )),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (c, i) {
                  return SizedBox(
                    height: 15.h,
                  );
                },
                itemCount: PlayerState.currentAlbum.songs.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
