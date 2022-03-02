import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:operatic_drive/constants.dart';


class buildPopupDialog extends StatefulWidget {
  @override
  _buildPopupDialogState createState() => new _buildPopupDialogState();
}

class _buildPopupDialogState extends State<buildPopupDialog>{
  int primary = 150;

  @override
  Widget build(BuildContext context) {
    return new Dialog(
    backgroundColor: themeColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    elevation: 16,
    child: new Container(
      child: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(height: 20),
      Container(
          padding: EdgeInsets.only(left: 15.0, right: 5.0, top: 10.0, bottom: 10.0),
          alignment: Alignment.topLeft,
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 2, color: Colors.grey)),
                  child: Icon(Icons.keyboard_arrow_left, color: Colors.white,)))),
      Container(
        padding: EdgeInsets.only(left: 15.0, right: 5.0, top: 10.0, bottom: 10.0),
        child: Text(
          "Choose your emotion",
          textAlign: TextAlign.left,
          style: GoogleFonts.montserrat(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            // stat screen
            children: [
              Expanded(
                child:Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment(-1.0, -1),
                        end: Alignment(1, -1),
                        colors: [Colors.red, Colors.green]
                    ),
                  ),
                  child: new GridView(

                    shrinkWrap: true,
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing:1, crossAxisSpacing: 1, crossAxisCount: 20),
                    children: List.generate(
                        400,
                            (index) =>new InkResponse(
                          child:Container(
                            // child: Text('a'),
                            decoration: (index==primary)?BoxDecoration(
                              gradient: RadialGradient(
                                  colors: [Colors.indigo.shade100, Colors.transparent]
                              ),
                            ):BoxDecoration(
                              color:Colors.transparent,
                            ),

                          ),
                          onTap: (){
                            print(index);
                            setState(() {
                              primary = index;
                            });

                          },
                        )
                    ),
                  ),
                ),
              )
            ]),
      ),
      Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.only(left: 15.0, right: 5.0, top: 10.0, bottom: 10.0),
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              color: themeColor,
              borderRadius: BorderRadius.circular(15)),
          child: TextButton(
              onPressed: () {
                // if (name.isNotEmpty &&
                //     price.isNotEmpty &&
                //     description.isNotEmpty &&
                //     category.isNotEmpty &&
                //     imagePath.isNotEmpty) {
                //   BlocProvider.of<VendorProfileCubit>(context).addFood(
                //       context, name, category, description, price, imagePath);
                //   resetValue();
                // } else {
                //   final snackBar = SnackBar(
                //       content: Text(
                //           'Error: All fields should be entered before adding item!'));
                //
                //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                // }
              },
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "Generate Playlist",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.white,
                )
              ]))),
          SizedBox(height: 20),
        ],
      ),
    ),
  );
  }
}

// Widget buildPopupDialog(BuildContext context) {
//   int primary = 150;
//   final backButton = Container(
//       padding: EdgeInsets.only(left: 15.0, right: 5.0, top: 10.0, bottom: 10.0),
//       alignment: Alignment.topLeft,
//       child: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   border: Border.all(width: 2, color: Colors.grey)),
//               child: Icon(Icons.keyboard_arrow_left, color: Colors.white,))));
//
//   final header = Container(
//     padding: EdgeInsets.only(left: 15.0, right: 5.0, top: 10.0, bottom: 10.0),
//     child: Text(
//       "Choose your emotion",
//       textAlign: TextAlign.left,
//       style: GoogleFonts.montserrat(
//           fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
//     ),
//   );
//
//   final addButton = Container(
//       margin: EdgeInsets.all(5),
//       padding: EdgeInsets.only(left: 15.0, right: 5.0, top: 10.0, bottom: 10.0),
//       decoration: BoxDecoration(
//           border: Border.all(
//             color: Colors.grey,
//           ),
//           color: themeColor,
//           borderRadius: BorderRadius.circular(15)),
//       child: TextButton(
//           onPressed: () {
//             // if (name.isNotEmpty &&
//             //     price.isNotEmpty &&
//             //     description.isNotEmpty &&
//             //     category.isNotEmpty &&
//             //     imagePath.isNotEmpty) {
//             //   BlocProvider.of<VendorProfileCubit>(context).addFood(
//             //       context, name, category, description, price, imagePath);
//             //   resetValue();
//             // } else {
//             //   final snackBar = SnackBar(
//             //       content: Text(
//             //           'Error: All fields should be entered before adding item!'));
//             //
//             //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
//             // }
//           },
//           child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//             Text(
//               "Generate Playlist",
//               textAlign: TextAlign.center,
//               style: GoogleFonts.montserrat(
//                   fontWeight: FontWeight.bold, color: Colors.white),
//             ),
//             Icon(
//               Icons.keyboard_arrow_right,
//               color: Colors.white,
//             )
//           ])));
//   final emotionSpectrum = Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         // stat screen
//         children: [
//           Expanded(
//             child:Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                     begin: Alignment(-1.0, -1),
//                     end: Alignment(1, -1),
//                     colors: [Colors.red, Colors.green]
//                 ),
//               ),
//               child: new GridView(
//
//                 shrinkWrap: true,
//                 gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//                     mainAxisSpacing:1, crossAxisSpacing: 1, crossAxisCount: 20),
//                 children: List.generate(
//                     400,
//                         (index) =>new InkResponse(
//                       child:Container(
//                         // child: Text('a'),
//                         decoration: (index==primary)?BoxDecoration(
//                           gradient: RadialGradient(
//                               colors: [Colors.indigo.shade100, Colors.transparent]
//                           ),
//                         ):BoxDecoration(
//                           color:Colors.transparent,
//                         ),
//
//                       ),
//                       onTap: (){
//                         print(index);
//                         primary = index;
//
//                       },
//                     )
//                 ),
//               ),
//             ),
//           )
//         ]),
//   );
//   return new Dialog(
//     backgroundColor: themeColor,
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//     elevation: 16,
//     child: new Container(
//       child: new ListView(
//         shrinkWrap: true,
//         children: <Widget>[
//           SizedBox(height: 20),
//           backButton,
//           header,
//           emotionSpectrum,
//           addButton,
//           SizedBox(height: 20),
//         ],
//       ),
//     ),
//   );
// }
