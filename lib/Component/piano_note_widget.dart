import 'package:flutter/material.dart';
import 'package:guitar_vis_f/shared_info.dart';

class pianoKeyWidget extends StatelessWidget {
  final int note;
  final bool inscale;
  final bool inchord;
  final int keysshown;

  pianoKeyWidget({
    Key key,
    this.note,
    this.inscale,
    this.inchord,
    this.keysshown,
  }) : super(key: key);

  Widget noteWidget(int notenum, bool highlight) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: highlight ? 40.0 : 30.0,
        height: highlight ? 40.0 : 30.0,

        decoration: BoxDecoration(
          color: getColor((notenum % 12).toDouble()),
          shape: BoxShape.circle,
          border: highlight ? new Border.all(
            color: (sharps.contains(notenum % 12)) ? Colors.white : Colors
                .black,
            width: 2.5,
          ) : Border(),

        ), // Box Decoration

        child: OverflowBox(
          child: Center(child: RichText(
            text: TextSpan(
              text: notenames[notenum % 12],
              style: TextStyle(fontSize: 12.0,
                  color: highlight ? Colors.black : Colors.white,
                  fontStyle: highlight ? FontStyle.normal : FontStyle.normal),
            ), // TextSpan
          ), // Rich Text
          ),
        ), // Center
      ), // Container
    ); //Stack
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only( bottom: (sharps.contains(note%12)) ? 20.0: 1.0),
      child: new Container(
        width: 40.0,
        //color: (keyname.contains("sharp")) ? Colors.black : Colors.white10,
        decoration: BoxDecoration(

          color: (sharps.contains(note%12)) ? Colors.black : Colors.white,
          border: Border(
            left: BorderSide(color: Colors.grey, width: 1.0),
            right: BorderSide(color: Colors.grey, width: 1.0),
            bottom: BorderSide(color: Colors.white24, width: 1.0),
          ),

        ),

        child: inscale ? Container(
          color: inchord ?
          getColor((note%12).toDouble()).withOpacity(0.5): (sharps.contains(note%12)) ? Colors.black : Colors.white,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: noteWidget(note, inchord),
          ),
        ): Container(),
      ),
    );
  }
}
