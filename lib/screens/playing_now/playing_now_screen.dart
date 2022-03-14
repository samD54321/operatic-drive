import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app_ui/res/assets.dart';
import 'package:music_app_ui/util/navigation/navigation_service.dart';
import 'package:music_app_ui/util/utils.dart';

class PlayingNowScreen extends StatefulWidget {
  const PlayingNowScreen({Key? key}) : super(key: key);

  @override
  _PlayingNowScreenState createState() => _PlayingNowScreenState();
}

class _PlayingNowScreenState extends State<PlayingNowScreen> {
  int valueHolder = 20;

  @override
  Widget build(BuildContext context) {
    Utils.playingState = setState;
    print(
        ' position: ${(PlayerState.position.inSeconds / PlayerState.songLength.inSeconds) * 1000}');
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            GetIt.I.get<NavigationService>().back();
          },
          child: SvgPicture.asset(
            Assets.BACK,
            height: 24,
            width: 24,
            color: Utils.color,
            // fit: BoxFit.fill,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 16.h, left: 20.w, right: 20.w),
                child: SvgPicture.asset(Assets.SONG, height: 100, width: 100),
              ),
            ),
            SizedBox(height: 22.h),
            Padding(
              padding: EdgeInsets.only(left: 39.w, right: 39.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    Assets.HEART_OUTLINED,
                    color: Utils.color,
                    colorBlendMode: BlendMode.srcATop,
                    height: 24.w,
                    width: 24.w,
                    fit: BoxFit.fill,
                  ),
                  Text(
                    PlayerState.currentSong.title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        fontSize: (24 - 5).sp,
                        color: Colors.white,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    Assets.DOWNLOAD,
                    color: Utils.color,
                    colorBlendMode: BlendMode.srcATop,
                    height: 24.w,
                    width: 24.w,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              PlayerState.currentSong.album,
              textAlign: TextAlign.center,
              style: GoogleFonts.workSans(
                textStyle: TextStyle(
                  fontSize: (14 - 5).sp,
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 50.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 36.w),
              child: SliderTheme(
                data: SliderThemeData(
                    overlayShape: SliderComponentShape.noOverlay),
                child: Slider(
                    value: (PlayerState.position.inSeconds /
                            PlayerState.songLength.inSeconds) *
                        100,
                    min: 0,
                    max: 100,
                    activeColor: Utils.color,
                    inactiveColor: const Color(0x4fffffff),
                    label: '${valueHolder.round()}',
                    onChanged: (double newValue) {
                      setState(() {
                        var position = Duration(
                            seconds: (PlayerState.songLength.inSeconds *
                                    newValue /
                                    100)
                                .round());
                        audioPlayer.seek(position.inSeconds.toDouble());
                        print(PlayerState.position.inSeconds);
                      });
                    },
                    semanticFormatterCallback: (double newValue) {
                      var position = Duration(
                          seconds: (PlayerState.songLength.inSeconds *
                                  newValue /
                                  100)
                              .round());
                      return "${position.inMinutes.remainder(60)}:${position.inSeconds.remainder(60)}";
                    }),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 36.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${PlayerState.position.inMinutes.remainder(60)}:${PlayerState.position.inSeconds.remainder(60)}",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.workSans(
                      textStyle: TextStyle(
                        fontSize: (18 - 5).sp,
                        color: Utils.color,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(
                    "${PlayerState.songLength.inMinutes.remainder(60)}:${PlayerState.songLength.inSeconds.remainder(60)}",
                    textAlign: TextAlign.right,
                    style: GoogleFonts.workSans(
                      textStyle: TextStyle(
                        fontSize: (18 - 5).sp,
                        color: Utils.color,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.only(left: 42.w, right: 42.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    Assets.SHUFFLE,
                    color: Utils.color,
                    colorBlendMode: BlendMode.srcATop,
                    height: 24.w,
                    width: 24.w,
                    fit: BoxFit.fill,
                  ),
                  InkWell(
                      child: SvgPicture.asset(
                        Assets.SKIP_BACKWARD,
                        height: 24.w,
                        width: 24.w,
                        fit: BoxFit.fill,
                      ),
                      onTap: () {
                        setState(() {
                          Utils.previous();
                        });
                      }),
                  InkWell(
                    child: Utils.playerState == PlayerState.PLAYING
                        ? Container(
                            width: 54.w,
                            height: 54.w,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  colorFilter: ColorFilter.mode(
                                      Utils.color, BlendMode.srcATop),
                                  image: const AssetImage(Assets.PAUSE),
                                  fit: BoxFit.fitHeight),
                            ),
                          )
                        : SvgPicture.asset(
                            Assets.PLAY,
                            color: Utils.color,
                            colorBlendMode: BlendMode.srcATop,
                            width: 54.w,
                            height: 54.w,
                            fit: BoxFit.fill,
                          ),
                    onTap: () async {
                      Utils.playerState == PlayerState.PLAYING
                          ? {
                              Utils.pause(),
                              setState(() {
                                Utils.playerState = PlayerState.PAUSED;
                              })
                            }
                          : {
                              Utils.play(),
                              setState(() {
                                Utils.playerState = PlayerState.PLAYING;
                              })
                            };
                    },
                  ),
                  InkWell(
                      child: SvgPicture.asset(
                        Assets.SKIP_FORWARD,
                        height: 24.w,
                        width: 24.w,
                        fit: BoxFit.fill,
                      ),
                      onTap: () {
                        print("water");
                        setState(() {
                          Utils.next();
                        });
                      }),
                  SvgPicture.asset(
                    Assets.REPEAT,
                    height: 24.w,
                    width: 24.w,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ),
            SizedBox(height: 39.h),
          ],
        ),
      ),
    );
  }
}
