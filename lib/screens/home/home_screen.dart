import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app_ui/res/assets.dart';
import 'package:music_app_ui/util/utils.dart';

class HomeScreen extends StatefulWidget {
  final bool isCurrent;

  const HomeScreen({Key? key, required this.isCurrent}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  List<String> trendingAlbums = [
    "assets/png/home/home1.png",
    "assets/png/home/home2.png",
    "assets/png/home/home3.png"
  ];

  List<String> trendingSongs = [
    "assets/png/home/home4.png",
    "assets/png/home/home5.png",
    "assets/png/home/home6.png"
  ];

  int selectedCategoryIndex = 1;
  @override
  Widget build(BuildContext context) {
    Utils.setState = setState;
    Utils.initPlayer();
    return Offstage(
      offstage: !widget.isCurrent,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            "OPERATIC DRIVE",
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: (26 - 5).sp,
                color: Colors.white,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          centerTitle: false,
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        body: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            padding: EdgeInsets.only(
              top: 19.h,
              left: 20.w,
            ),
            children: [
              SizedBox(
                height: 30.h,
                width: double.infinity,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length - 4,
                  itemBuilder: (c, i) {
                    return Container(
                      height: 38.h,
                      decoration: BoxDecoration(
                        color: selectedCategoryIndex == i
                            ? Color.fromARGB(102, 198, 231, 12)
                            : colors[i],
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(70.r),
                        ),
                      ),
                      child: Center(
                          child: Text(
                        categories[i],
                        style: GoogleFonts.workSans(
                          textStyle: TextStyle(
                            fontSize: (20 - 5).sp,
                            color: Color.fromARGB(255, 10, 10, 10),
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )),
                      padding: EdgeInsets.only(left: 21.w, right: 22.w),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 8.w,
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 18.h, bottom: 15.h),
              ),
              SizedBox(
                height: 30.h,
                width: double.infinity,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length - 4,
                  itemBuilder: (c, i) {
                    return Container(
                      height: 38.h,
                      decoration: BoxDecoration(
                        color: selectedCategoryIndex == i + 4
                            ? Color.fromARGB(102, 198, 231, 12)
                            : colors[i + 4],
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(70.r),
                        ),
                      ),
                      child: Center(
                          child: Text(
                        categories[i + 4],
                        style: GoogleFonts.workSans(
                          textStyle: TextStyle(
                            fontSize: (20 - 5).sp,
                            color: Color.fromARGB(255, 10, 10, 10),
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )),
                      padding: EdgeInsets.only(left: 21.w, right: 22.w),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 8.w,
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 18.h, bottom: 15.h),
                child: Text(
                  "Trending Albums",
                  style: GoogleFonts.workSans(
                    textStyle: TextStyle(
                      fontSize: (24 - 5).sp,
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 127.r,
                width: double.infinity,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  scrollDirection: Axis.horizontal,
                  itemCount: trendingAlbums.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (c, i) {
                    return Container(
                      width: 127.r,
                      height: 127.r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        image: DecorationImage(
                          image: AssetImage(trendingAlbums[i]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 17.w,
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 41.h, bottom: 15.h),
                child: Text(
                  "Songs",
                  style: GoogleFonts.workSans(
                    textStyle: TextStyle(
                      fontSize: (24 - 5).sp,
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 127.r,
                width: double.infinity,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  scrollDirection: Axis.horizontal,
                  itemCount: trendingSongs.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (c, i) {
                    return Container(
                      width: 127.r,
                      height: 127.r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        image: DecorationImage(
                          image: AssetImage(trendingSongs[i]),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: const Text(
                        'Hello, ! How are you?',
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 17.w,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
