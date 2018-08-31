import 'package:flutter/material.dart';

List<String> notenames = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B" ];
List<int> rootnotes = [4, 9, 14, 19, 23, 28];
List<List<int>> tunings = [[4, 9, 14, 19, 23, 28],[2, 9, 14, 19, 23, 28], // Drop D
[2, 9, 14, 19, 23, 26], // Double drop d
[2, 7, 14, 19, 23, 26] // open G
];

List<int> majorscale = [0,2,4,5,7,9,11,12,14,16,17,19,21,23,24];

class animatedGuitarWidget extends StatefulWidget {
  final List<bool> notesShown;
  final List<bool> octavesShown;
  final int tuning;
  final int rootnote;
  final int tonalhighlight;


  animatedGuitarWidget({
    this.notesShown = const[true,true,true,true,true,true,true,true,true,true,true,true],
    this.octavesShown = const [true,true,true,true],
    this.tuning = 0,
    this.rootnote = -1,
    this.tonalhighlight =0,
  });

  @override
  _guitarWidgetState createState() => new _guitarWidgetState();
}

class _guitarWidgetState extends State<animatedGuitarWidget> {

  List<int> notesh ;
  List<Widget> Frets;
  bool loaded = false;

  @override
  void initState() {
    /* setState(() {
      loaded = false;
    });
*/
    setState(() {
      (widget.rootnote != -1) ? notesh = [(widget.rootnote+majorscale[widget.tonalhighlight])%12,
      (widget.rootnote+majorscale[widget.tonalhighlight + 2])%12,
      (widget.rootnote+majorscale[widget.tonalhighlight+ 4])%12] : [];

      Frets = _buildFrets();
      print(notesh);
    });
    setState(() {
      loaded = true;
    });
  }


  @override
  void didUpdateWidget(animatedGuitarWidget oldWidget) {
    setState(() {
      (widget.rootnote != -1) ? notesh = [(widget.rootnote+majorscale[widget.tonalhighlight])%12,
      (widget.rootnote+majorscale[widget.tonalhighlight + 2])%12,
      (widget.rootnote+majorscale[widget.tonalhighlight+ 4])%12] : [];

      Frets = _buildFrets();
      print(notesh);
    });
  }

  List<Widget> _buildFrets() {
    List<Widget> frets = [];
    for (int fret = 0; fret< 13; ++fret) {
      frets.add(_buildFret(fret));
    }
    return frets;
    // 49 C#/ 51 D#/ 54 F#/ 56 G#/ 58 A#/ //61 / 63/ 66/ 68/ 70
  }

  Color getColor(double tnote) {
    return Color.lerp(Colors.red, Colors.blue, tnote / 12);
  }
  void onPressed(int note, int string) {
    print(" note is ${notenames[note%12]} on the ${string+1} string");
  }
  Widget _buildFret(int fretnum) {
    return new Container(

        width: 60.0,
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
            children: _buildNotes(fretnum, widget.tuning)..add(
                Container(height: 10.0, width: 10.0, child: RichText(
                  text: TextSpan(
                    text: "$fretnum",
                    style: TextStyle(fontSize: 8.0, color: Colors.black, fontStyle: FontStyle.normal),
                  ), // TextSpan
                ), // Rich Text))
                )
            )));
  }

  List<Widget> _buildNotes(int fretnum, int tuning) {

    List<Widget> notes = [];
    for (int string = 0; string<6; ++string) { // High e to low e
      // for (int string = 5; string>=0; --string) {
      int note = tunings[tuning][string] + fretnum;
      (widget.notesShown[note%12] && widget.octavesShown[(note/12).floor()])

          ? notes.add(noteWidget(note, string, notesh.isEmpty ? false : notesh.contains(note%12)))

          : notes.add(Container(height: 45.0,child: Divider(height: 40.0, color: Colors.black,),));
    }
    return notes;

  }

  Widget noteWidget(int notenum, int string, bool highlight) {

    return GestureDetector(
      onTap: () => onPressed(notenum, string),
      child: Stack(
          children: <Widget>[
            Center(child: Divider(height: 45.0, color: Colors.black,),
            ),
            Padding(
              padding: const EdgeInsets.only( top: 5.0),
              child: Opacity(
                opacity: 0.9,
                child: Center(
                  child: Container(
                    width: highlight ? 35.0:26.0,
                    height: highlight ? 35.0:26.0,
                    decoration: BoxDecoration(
                      color: getColor((notenum%12).toDouble()),
                      shape: BoxShape.circle,
                    ), // Box Decoration
                    child: Center(child: RichText(
                      text: TextSpan(
                        text: notenames[notenum%12],
                        style: TextStyle(fontSize: 12.0, color: highlight ?Colors.black: Colors.white, fontStyle: highlight ?FontStyle.normal : FontStyle.normal),
                      ), // TextSpan
                    ), // Rich Text
                    ), // Center
                  ),
                ),
              ),  // Container
            ), // Padding

          ]
      ),
    );  //Stack
  }

  @override
  Widget build(BuildContext context) {
    return new ListView(
      scrollDirection: Axis.horizontal,
      children: loaded ? _buildFrets(): [],

    ); // ListView;
  }


}