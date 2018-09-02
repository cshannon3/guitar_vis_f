import 'package:flutter/material.dart';
import 'package:guitar_vis_f/Component/guitar/note_widget.dart';
import 'package:guitar_vis_f/shared_info.dart';



class instrumentWidget extends StatefulWidget {
  //final List<bool> notesShown;
  //final List<bool> octavesShown;
  final int tuning;
  final int rootnote;
  final int tonalhighlight;
  final int currentscale;
  final int currentchord;



  instrumentWidget({
    // this.notesShown = const[true,true,true,true,true,true,true,true,true,true,true,true],
    // this.octavesShown = const [true,true,true,true],
    this.tuning = 0,
    this.rootnote = -1,
    this.tonalhighlight =0,
    this.currentscale = -1,
    this.currentchord = -1,

  });

  @override
  _guitarWidgetState createState() => new _guitarWidgetState();
}

class _guitarWidgetState extends State<instrumentWidget> {

  //List<int> noteshighlighted;

  //List<Widget> Frets;
  bool loaded = false;
  int fretsshown = 6;
  int keysshown = 10;

  int rootindex;
  List<int> scalenotes = [];
  List<int> chordnotes = [];
  bool showall = true;
  bool guitaron = true;



  List<int> _buildscalenoteslist(int _root, int _currentscale) {
    List<int> scale = [];
    for (int i=0; i<7;i++){
      scale.add((_root+scales[_currentscale][i])%12);
    }
    return scale;
  }
  List<int> _buildhighlights(int _root, int _currentscale, int _tonalhighlight){
    return
      [(_root + scales[_currentscale][_tonalhighlight]) % 12,
      (_root + scales[_currentscale][_tonalhighlight + 2]) % 12,
      (_root + scales[_currentscale][_tonalhighlight + 4]) % 12
      ];
  }
  List<int> _buildchordnoteslist(int _root, int _currentchord){
    List<int> _chordnotes = [];
    for (int u = 0; u < chords[_currentchord].length; u++){
      _chordnotes.add((_root + chords[_currentchord][u]) % 12);
    }
    return _chordnotes;
  }


  @override
  void initState() {
    setState(() {
      if (widget.rootnote == -1){
        showall = true;
      }
      else if (widget.currentscale != -1){
        showall= false;
        rootindex = scales[widget.currentscale].indexOf(widget.rootnote%12);
        scalenotes = _buildscalenoteslist(widget.rootnote, widget.currentscale);
        chordnotes = _buildhighlights(widget.rootnote, widget.currentscale, widget.tonalhighlight);
      }
      else if (widget.currentchord != -1)  {
        showall= false;
        chordnotes = _buildchordnoteslist(widget.rootnote, widget.currentchord);
        scalenotes = chordnotes;
      }
      else{showall = true;}
    });
    setState(() {
      loaded = true;
    });
  }


  @override
  void didUpdateWidget(instrumentWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      loaded = false;
      if (widget.rootnote == -1){
        showall = true;
      }
      else if (widget.currentscale != -1){
        showall= false;
        rootindex = scales[widget.currentscale].indexOf(widget.rootnote%12);
        scalenotes = _buildscalenoteslist(widget.rootnote, widget.currentscale);
        chordnotes = _buildhighlights(widget.rootnote, widget.currentscale, widget.tonalhighlight);
      }
      else if (widget.currentchord != -1)  {
        showall= false;
        chordnotes = _buildchordnoteslist(widget.rootnote, widget.currentchord);
        scalenotes = chordnotes;
      }
      else{showall = true;}
    });
    setState(() {
      loaded = true;
    });
  }

  List<Widget> _buildFrets(double _screenwidth) {
    double fretwidth = _screenwidth / fretsshown;
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
      notes.add(
          noteWidget(
              note: note,
              string:string,
              fretwidth: fretwidth,
              inscale:showall ? true: scalenotes.contains(note % 12),
              inchord: showall ? false : chordnotes.contains(note % 12),
              fretsshown: fretsshown,
              scalepos: (showall || !scalenotes.contains(note%12)) ? null : scalenotes.indexOf(note%12)
    ));
    }
    return notes;
  }

  List<Widget> _buildKeys() {
    List<Widget> keys = [];
    for (int p = 0; p< 36; ++p) {
      keys.add(_buildKey(p));
    }
    return keys;
    // 49 C#/ 51 D#/ 54 F#/ 56 G#/ 58 A#/ //61 / 63/ 66/ 68/ 70
  }
  /* _playNote(int keyname) async {
    await Flame.audio.play("piano_${keyname}.mp3");
  }*/
  Widget _buildKey(int keyname) {
    return Padding(
      padding: EdgeInsets.only( bottom: (sharps.contains(keyname%12)) ? 20.0: 1.0),
      child: new Container(
        width: 40.0,
        //color: (keyname.contains("sharp")) ? Colors.black : Colors.white10,
        decoration: BoxDecoration(

          color: (sharps.contains(keyname%12)) ? Colors.black : Colors.white,
          border: Border(
            left: BorderSide(color: Colors.grey, width: 1.0),
            right: BorderSide(color: Colors.grey, width: 1.0),
            bottom: BorderSide(color: Colors.white24, width: 1.0),
          ),

        ),

        child: !showall ? (scalenotes.contains(keyname%12)) ? Container(
          color: chordnotes.contains(keyname%12) ?
          getColor((keyname%12).toDouble()).withOpacity(0.5): (sharps.contains(keyname%12)) ? Colors.black : Colors.white,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: noteWidget2(keyname, chordnotes.contains(keyname%12)),
          ),
        ): Container(): Container(),
      ),
    );
  }
  Widget noteWidget2(int notenum, bool highlight) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: highlight ? 40.0:30.0,
        height: highlight ? 40.0:30.0,

        decoration: BoxDecoration(
          color: getColor((notenum%12).toDouble()),
          shape: BoxShape.circle,
          border: highlight ? new Border.all(
            color: (sharps.contains(notenum%12)) ? Colors.white : Colors.black,
            width: 2.5,
          ) : Border(),

        ), // Box Decoration

        child: Center(child: RichText(
          text: TextSpan(
            text: notenames[notenum%12],
            style: TextStyle(fontSize: 12.0, color: highlight ?Colors.black: Colors.white, fontStyle: highlight ?FontStyle.normal : FontStyle.normal),
          ), // TextSpan
        ), // Rich Text
        ), // Center
      ),  // Container
    );  //Stack
  }





  @override
  Widget build(BuildContext context) {
    final double screen_width = MediaQuery
        .of(context)
        .size
        .width;
    print(screen_width);
    return new Column(
      children: <Widget>[
        Container(
          height: 40.0,
          color: Colors.blue,
          child: IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  guitaron = !guitaron;
                });
              }
          ),
        ),
        Container(
      height: 300.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: guitaron ? _buildFrets(screen_width) : _buildKeys(),
      ),
        ),
        Expanded(child: Container(),)
],
    ); // ListView;
  }


}