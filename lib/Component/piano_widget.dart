
import 'package:flutter/material.dart';
import 'package:guitar_vis_f/shared_info.dart';


class pianoWidget extends StatefulWidget {
  final List<bool> notesShown;
  final int rootnote;
  final int tonalhighlight;

  pianoWidget({
    this.notesShown = const[true,true,true,true,true,true,true,true,true,true,true,true],
    this.rootnote = 0,
    this.tonalhighlight =0,
});

  @override
  _pianoWidgetState createState() => new _pianoWidgetState();
}

class _pianoWidgetState extends State<pianoWidget> {
  List<int> noteshighlighted ;


  @override
  void initState() {
    (widget.rootnote != -1) ? noteshighlighted = [(widget.rootnote+majorscale[widget.tonalhighlight])%12,
    (widget.rootnote+majorscale[widget.tonalhighlight + 2])%12,
    (widget.rootnote+majorscale[widget.tonalhighlight+ 4])%12] : [];
  }

  @override
  void didUpdateWidget(pianoWidget oldWidget) {
    setState(() {
      (widget.rootnote != -1) ? noteshighlighted = [(widget.rootnote+majorscale[widget.tonalhighlight])%12,
      (widget.rootnote+majorscale[widget.tonalhighlight + 2])%12,
      (widget.rootnote+majorscale[widget.tonalhighlight+ 4])%12] : [];
      print(noteshighlighted);
    });
  }

  Color getColor(double tnote) {
    return Color.lerp(Colors.red, Colors.blue, tnote / 12);
  }

  List<Widget> _buildKeys2() {
    List<Widget> keys = [];
    for (int p = 0; p< 36; ++p) {
      keys.add(_buildKey2(p));
    }
    return keys;
    // 49 C#/ 51 D#/ 54 F#/ 56 G#/ 58 A#/ //61 / 63/ 66/ 68/ 70
  }
 /* _playNote(int keyname) async {
    await Flame.audio.play("piano_${keyname}.mp3");
  }*/
  Widget _buildKey2(int keyname) {
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

        padding: EdgeInsets.all( 1.0),
        child: (widget.notesShown[keyname%12]) ? Align(
          alignment: Alignment.bottomCenter,
          child: noteWidget(keyname, noteshighlighted.isEmpty ? false : noteshighlighted.contains(keyname%12)),
        ): Container(),
      ),
    );
  }
  Widget noteWidget(int notenum, bool highlight) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Opacity(
        opacity: 0.9,
        child: Container(
          width: highlight ? 40.0:30.0,
          height: highlight ? 40.0:30.0,

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
              children: _buildKeys2(),
            ),
    ) // ListView
       ;
  }
}
