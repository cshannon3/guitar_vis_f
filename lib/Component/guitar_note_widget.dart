import 'package:flutter/material.dart';
import 'package:guitar_vis_f/shared_info.dart';
class guitarNoteWidget extends StatelessWidget {
  final int note;
  final int string;
  final double fretwidth;
  final bool inscale;
  final bool inchord;
  final int fretsshown;
  final int scalepos;
  final bool intab;

  guitarNoteWidget({Key key,
    this.note,
    this.string,
    this.fretwidth,
    this.inscale,
    this.inchord,
    this.fretsshown,
    this.scalepos,
    this.intab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: (){},// => onPressed(note, string),
      child: Container(
        height: fretwidth*(2/3),
        child: Stack(
            children: <Widget>[
              Center(
                child: Divider(height: fretwidth * (2 / 3), color: Colors.black,),
              ),
              inscale || intab ?
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Opacity(
                  opacity: inchord || intab ? 0.9 : 0.6,
                  child: Center(
                    child: Container(
                      width: inchord || intab ? 36.0 - fretsshown : 32.0 - fretsshown,
                      height:inchord || intab ? 36.0 - fretsshown : 32.0 - fretsshown,
                      decoration: BoxDecoration(
                        color: getColor((note % 12).toDouble()),
                        shape: BoxShape.circle,
                        border: inchord || intab ? new Border.all(
                          color: Colors.white,
                          width: 2.5,
                        ) : Border(),
                      ), // Box Decoration

                      child: (fretsshown<9)?OverflowBox(
                        maxWidth: 30.0,
                        minWidth: 20.0,
                        child: Center(child:
                        RichText(
                          text: TextSpan(
                            text: "${scalepos ?? ""} ${notenames[note % 12]}",
                            style: TextStyle(fontSize: 12.0,
                                color: inchord || intab ? Colors.black : Colors.white,
                                fontWeight: FontWeight.bold),
                          ), // TextSpan
                        ), // Rich Text
                        ),
                      ): Container(), // Center
                    ),
                  ),
                ), // Container
              ): Container(), // Padding

            ]
        ),
      ),
    ); //Stack
  }
  }

