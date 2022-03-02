import 'package:google_fonts/google_fonts.dart';
import 'package:operatic_drive/emotion.dart';
import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int primary = 150;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [const Color(0xFF61C9BE07564D), const Color(0xFF07564D)],
        //   ),
        // ),
        child: ListView(children: <Widget>[
          Container(height: 40.0),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(15.0),
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: "Welcome, ",
                          style: GoogleFonts.montserrat(
                            color: const Color(0xFFFFFFFF),
                            fontSize: 20.0,
                          )),
                      TextSpan(
                          text: "User",
                          style: GoogleFonts.montserrat(
                            color: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          )),
                    ]),
                  ),
                )
              ]),

          // Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Expanded(
          //         child: Container(
          //           decoration: BoxDecoration(
          //             border: Border.all(
          //               color: Colors.white,
          //             ),
          //             borderRadius: BorderRadius.all(Radius.circular(20)),
          //             color: Colors.white,
          //           ),
          //           padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
          //           margin: const EdgeInsets.fromLTRB(15, 9, 15, 9),
          //           child: RichText(
          //             textAlign: TextAlign.left,
          //             text: TextSpan(children: <TextSpan>[
          //               TextSpan(
          //                   text: "Sampanna Dahal\n",
          //                   style: TextStyle(
          //                     color: const Color(0xFF236D9A),
          //                     fontWeight: FontWeight.bold,
          //                     fontSize: 20,
          //                   )),
          //
          //             ]),
          //           ),
          //         ),
          //       ),
          //     ]),
          Row(children: [
            Container(height: 10),
          ]),
          Row(children: [
            Container(height: 10),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                height: 40,
                child: Text("Choose your emotion :",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        fontSize: 18,

                        color: Colors.white))),
          ]),
          // Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     mainAxisSize: MainAxisSize.min,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     // stat screen
          //     children: [
          //       Expanded(
          //         child: LineChartWidget(
          //             thisWeeksExpense(dropdownValue), dropdownValue),
          //       )
          //     ]),



          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.transparent,
                    ),
                    padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                    margin: const EdgeInsets.fromLTRB(15, 9, 15, 9),
                    child: TextButton(
                      child: Text('Choose emotion',
                          style: GoogleFonts.montserrat(
                            color: const Color(0xFFffffff),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return buildPopupDialog();
                            });
                      },
                    ),
                  ),
                ),
              ]),
        ]));
  }
}
