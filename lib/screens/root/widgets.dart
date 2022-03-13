import 'package:flutter/material.dart';
import 'package:music_app_ui/util/utils.dart';

Widget _buildReviewDialog(BuildContext context, setState, widget) {
  final backButton = Container(
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
              child: const Icon(Icons.keyboard_arrow_left))));

  final header = Container(
    padding:
        const EdgeInsets.only(left: 15.0, right: 5.0, top: 10.0, bottom: 10.0),
    child: Text(
      "Add Server Address",
      textAlign: TextAlign.left,
      style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
    ),
  );

  final reviewField = Container(
      padding: EdgeInsets.only(left: 15.0, right: 5.0, top: 10.0, bottom: 10.0),
      decoration: BoxDecoration(
          color: const Color(0xFFFFFF), borderRadius: BorderRadius.circular(5)),
      child: TextFormField(
        maxLines: 5,
        minLines: 1,
        decoration: InputDecoration(
            hintText: "https://waterlilystation.ftp.json..",
            prefixIcon: Icon(
              Icons.link,
            )),
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (value) {
          Utils.serverLink = value;
        },
        onChanged: (value) {
          Utils.serverLink = value;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "The review field cannot be empty";
          }
          return null;
        },
      ));

  final submitButton = Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.only(
          left: 15.0, right: 5.0, top: 10.0, bottom: 10.0),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 0, 0, 0),
          borderRadius: BorderRadius.circular(15)),
      child: TextButton(
          onPressed: () {
            if (Utils.serverLink.isNotEmpty) {
            } else {
              final snackBar = SnackBar(
                  content: const Text(
                      'Error: All fields should be entered before adding item!'));

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "Done",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: const Color(0xFF000000)),
            ),
            Icon(
              Icons.keyboard_arrow_right,
              color: Colors.black,
            )
          ])));
  return new Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    elevation: 16,
    child: new Container(
      child: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(height: 20),
          backButton,
          header,
          reviewField,
          submitButton,
          SizedBox(height: 20),
        ],
      ),
    ),
  );
}
