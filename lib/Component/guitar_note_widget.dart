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

  guitarNoteWidget({Key key,
    this.note,
    this.string,
    this.fretwidth,
    this.inscale,
    this.inchord,
    this.fretsshown,
    this.scalepos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: (){},// => onPressed(note, string),
      child: Stack(
          children: <Widget>[
            Center(
              child: Divider(height: fretwidth * (2 / 3), color: Colors.black,),
            ),
            inscale ?
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Opacity(
                opacity: inchord ? 0.9 : 0.6,
                child: Center(
                  child: Container(
                    width: inchord ? 36.0 - fretsshown : 32.0 - fretsshown,
                    height: inchord ? 36.0 - fretsshown : 32.0 - fretsshown,
                    decoration: BoxDecoration(
                      color: getColor((note % 12).toDouble()),
                      shape: BoxShape.circle,
                      border: inchord ? new Border.all(
                        color: Colors.white,
                        width: 2.5,
                      ) : Border(),
                    ), // Box Decoration

                    child: OverflowBox(
                      maxWidth: 30.0,
                      minWidth: 20.0,
                      child: Center(child:
                      RichText(
                        text: TextSpan(
                          text: "${scalepos ?? ""} ${notenames[note % 12]}",
                          style: TextStyle(fontSize: 12.0,
                              color: inchord ? Colors.black : Colors.white,
                              fontStyle: inchord ? FontStyle.normal : FontStyle
                                  .normal),
                        ), // TextSpan
                      ), // Rich Text
                      ),
                    ), // Center
                  ),
                ),
              ), // Container
            ): Container(), // Padding

          ]
      ),
    ); //Stack
  }
  }

