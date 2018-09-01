import 'package:flutter/material.dart';
import 'package:guitar_vis_f/shared_info.dart';



class guitarWidget extends StatefulWidget {
  final List<bool> notesShown;
  final List<bool> octavesShown;
  final int tuning;
  final int rootnote;
  final int tonalhighlight;
  final int currentscale;


  guitarWidget({
    this.notesShown = const[true,true,true,true,true,true,true,true,true,true,true,true],
    this.octavesShown = const [true,true,true,true],
    this.tuning = 0,
    this.rootnote = -1,
    this.tonalhighlight =0,
    this.currentscale = 0,
  });

  @override
  _guitarWidgetState createState() => new _guitarWidgetState();
}

class _guitarWidgetState extends State<guitarWidget> {

  List<int> noteshighlighted;

  List<Widget> Frets;
  bool loaded = false;
  int fretsshown = 6;

  @override
  void initState() {
    setState(() {
      (widget.rootnote != -1) ? noteshighlighted =
      [(widget.rootnote + scales[widget.currentscale][widget.tonalhighlight]) % 12,
      (widget.rootnote + scales[widget.currentscale][widget.tonalhighlight + 2]) % 12,
      (widget.rootnote + scales[widget.currentscale][widget.tonalhighlight + 4]) % 12
      ] : [];
    });
    setState(() {
      loaded = true;
    });
  }


  @override
  void didUpdateWidget(guitarWidget oldWidget) {
    setState(() {
      (widget.rootnote != -1) ? noteshighlighted =
      [(widget.rootnote + scales[widget.currentscale][widget.tonalhighlight]) % 12,
      (widget.rootnote + scales[widget.currentscale][widget.tonalhighlight + 2]) % 12,
      (widget.rootnote + scales[widget.currentscale][widget.tonalhighlight + 4]) % 12
      ] : [];


      print(noteshighlighted);
    });
  }

  List<Widget> _buildFrets(double _screenwidth) {
    double fretwidth = _screenwidth / fretsshown;
    print(fretwidth);
    List<Widget> frets = [];
    for (int fret = 0; fret < 13; ++fret) {
      frets.add(_buildFret(fret, fretwidth));
    }
    return frets;
  }


  void onPressed(int note, int string) {
    print(" note is ${notenames[note % 12]} on the ${string + 1} string");
  }

  Widget _buildFret(int fretnum, double fretwidth) {
    return new Container(
        width: fretwidth,
        //color: (keyname.contains("sharp")) ? Colors.black : Colors.white10,
        decoration: BoxDecoration(
          color: Colors.brown[300],
          border: Border(
            left: BorderSide(color: Colors.black, width: 1.0),
            right: BorderSide(color: Colors.black, width: 1.0),
            bottom: BorderSide(color: Colors.white24, width: 1.0),
          ),
        ),
        padding: EdgeInsets.all(1.0),
        child: Column(
            children: _buildNotes(fretnum, widget.tuning, fretwidth)
              ..add(
                  Container(child: RichText(
                    text: TextSpan(
                      text: "$fretnum",
                      style: TextStyle(fontSize: 10.0,
                          color: Colors.black,
                          fontStyle: FontStyle.normal),
                    ), // TextSpan
                  ), // Rich Text))
                  )
              )));
  }

  List<Widget> _buildNotes(int fretnum, int tuning, double fretwidth) {
    List<Widget> notes = [];
    for (int string = 0; string < 6; ++string) { // High e to low e
      // for (int string = 5; string>=0; --string) {
      int note = tunings[tuning][string] + fretnum;
      (widget.notesShown[note % 12] && widget.octavesShown[(note / 12).floor()])

          ? notes.add(noteWidget(note, string, fretwidth,
          noteshighlighted.isEmpty ? false : noteshighlighted.contains(
              note % 12)))

          : notes.add(Container(height: fretwidth * (2 / 3) /*45.0*/,
        child: Divider(height: fretwidth * (2 / 3), color: Colors.black,),));
    }
    return notes;
  }

  Widget noteWidget(int notenum, int string, double fretwidth, bool highlight) {
    return GestureDetector(
      onTap: () => onPressed(notenum, string),
      child: Stack(
          children: <Widget>[
            Center(
              child: Divider(height: fretwidth * (2 / 3), color: Colors.black,),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Opacity(
                opacity: highlight ? 0.9 : 0.6,
                child: Center(
                  child: Container(
                    width: highlight ? 36.0 - fretsshown : 32.0 - fretsshown,
                    height: highlight ? 36.0 - fretsshown : 32.0 - fretsshown,
                    decoration: BoxDecoration(

                      color: getColor((notenum % 12).toDouble()),
                      shape: BoxShape.circle,
                      border: highlight ? new Border.all(
                        color: Colors.white,
                        width: 2.5,
                      ) : Border(),


                    ), // Box Decoration

                    child: Center(child: RichText(
                      text: TextSpan(
                        text: notenames[notenum % 12],
                        style: TextStyle(fontSize: 12.0,
                            color: highlight ? Colors.black : Colors.white,
                            fontStyle: highlight ? FontStyle.normal : FontStyle
                                .normal),
                      ), // TextSpan
                    ), // Rich Text
                    ), // Center
                  ),
                ),
              ), // Container
            ), // Padding

          ]
      ),
    ); //Stack
  }

  @override
  Widget build(BuildContext context) {
    final double screen_width = MediaQuery
        .of(context)
        .size
        .width;
    print(screen_width);
    return new Container(
      height: 300.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: loaded ? _buildFrets(screen_width) : [],
      ),

    ); // ListView;
  }


}