import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app_ui/res/assets.dart';
import 'package:music_app_ui/util/navigation/navigation_service.dart';
import 'package:music_app_ui/util/navigation/routes.dart';
import 'package:music_app_ui/util/utils.dart';

class PlayingWidget extends StatefulWidget {
  const PlayingWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PlayingWidgetsState();
  }
}

class _PlayingWidgetsState extends State<PlayingWidget> {
  @override
  Widget build(BuildContext context) {
    Utils.playerSetState = setState;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            GetIt.I.get<NavigationService>().to(routeName: Routes.playingNow);
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              color: const Color(0xff1B1919),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 35.r,
                    height: 35.r,
                    margin: EdgeInsets.only(
                        top: 2.h, bottom: 3.h, left: 12.w, right: 15.w),
                    child: SvgPicture.asset(
                      Assets.SONG,
                    )),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        PlayerState.currentSong.title,
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: (20 - 5).sp,
                            color: Colors.white,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        PlayerState.currentSong.album,
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: (14 - 5).sp,
                            color: Colors.white,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 120.w,
                  height: 54.h,
                  margin: EdgeInsets.only(
                      top: 6.w, bottom: 6.w, left: 6.w, right: 12.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(Assets.PAUSE),
                                      fit: BoxFit.fitHeight),
                                ),
                              )
                            : SvgPicture.asset(
                                Assets.PLAY,
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
                    
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 2.h,
          child: Stack(
            fit: StackFit.loose,
            children: [
              Container(
                color: Colors.white,
              ),
              Container(
                width: MediaQuery.of(context).size.width 
                // *
                //     (PlayerState.position.inSeconds /
                //         PlayerState.songLength.inSeconds)
                ,
                color: const Color(0xffB87629),
              )
            ],
          ),
        )
      ],
    );
  }
}
