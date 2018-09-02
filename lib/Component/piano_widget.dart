
import 'package:flutter/material.dart';
import 'package:guitar_vis_f/shared_info.dart';


class pianoWidget extends StatefulWidget {
  //final List<bool> notesShown;
  final int rootnote;
  final int tonalhighlight;
  final int currentscale;
  final int currentchord;

  pianoWidget({
   // this.notesShown = const[true,true,true,true,true,true,true,true,true,true,true,true],
    this.rootnote = -1,
    this.tonalhighlight =0,
    this.currentscale = -1,
    this.currentchord = -1,
});

  @override
  _pianoWidgetState createState() => new _pianoWidgetState();
}

class _pianoWidgetState extends State<pianoWidget> {
  //List<int> noteshighlighted ;
  int fretsshown = 6;
  int rootindex;
  List<int> scalenotes = [];
  List<int> chordnotes = [];
  bool showall = true;
  int keysshown =10;
  bool loaded = false;

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
  void didUpdateWidget(pianoWidget oldWidget) {
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


  Color getColor(double tnote) {
    return Color.lerp(Colors.red, Colors.blue, tnote / 12);
  }
  List<int> _buildscalenoteslist(int _root, int _currentscale) {
    List<int> scale = [];
    for (int i=0; i<7;i++){
      scale.add((_root+scales[_currentscale][i])%12);
    }
    return scale;
  }
  List<int> _buildhighlights(int _root, int _currentscale, int _tonalhighlight){
    List<int> _chordnotes = [];
    for (int u = 0; u < 6; u+2){
      _chordnotes.add((_root + scales[_currentscale][_tonalhighlight + u]) % 12);

    }
    return _chordnotes;
    /*  [(_root + scales[_currentscale][_tonalhighlight + u]) % 12,
      (_root + scales[_currentscale][_tonalhighlight + 2]) % 12,
      (_root + scales[_currentscale][_tonalhighlight + 4]) % 12
      ];*/
  }
  List<int> _buildchordnoteslist(int _root, int _currentchord){
    List<int> _chordnotes = [];
    for (int u = 0; u < chords[_currentchord].length; u++){
      _chordnotes.add((_root + chords[_currentchord][u]) % 12);
    }
    return _chordnotes;
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

        child: showall ? (scalenotes.contains(keyname%12)) ? Container(
          color: chordnotes.contains(keyname%12) ?
        getColor((keyname%12).toDouble()).withOpacity(0.5): (sharps.contains(keyname%12)) ? Colors.black : Colors.white,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: noteWidget(keyname, chordnotes.contains(keyname%12)),
          ),
        ): Container(): Container(),
      ),
    );
  }
  Widget noteWidget(int notenum, bool highlight) {

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
    return Container(
      color: Colors.white,
      height: 200.0,
      child: new ListView(
        scrollDirection: Axis.horizontal,
              children: loaded ?_buildKeys(): [],
            ),
    ) // ListView
       ;
  }
}
