import 'package:flutter/material.dart';
import 'package:guitar_vis_f/Component/guitar_note_widget.dart';
import 'package:guitar_vis_f/Component/piano_note_widget.dart';
import 'package:guitar_vis_f/shared_info.dart';



class instrumentWidget extends StatefulWidget {
  final int tuning;
  final int rootnote;
  final int tonalhighlight;
  final int currentscale;
  final int currentchord;


  instrumentWidget({
    this.tuning = 0,
    this.rootnote = -1,
    this.tonalhighlight =0,
    this.currentscale = -1,
    this.currentchord = -1,

  });

  @override
  _instrumentWidgetState createState() => new _instrumentWidgetState();
}

class _instrumentWidgetState extends State<instrumentWidget> {


  int fretsshown = 6;
  int keysshown = 10;
  int rootindex;
  List<int> scalenotes = [];
  List<int> chordnotes = [];
  bool showall = true;
  bool guitaron = true;
  int currenttuning;

  List<String> _tunings = <String>[
    'EADGBe', 'DADGBe', 'DADGBd', 'DGDGBD',
  ];
  String _tuning;

  @override
  void initState() {
    super.initState();
    currenttuning = widget.tuning;
    _tuning = _tunings[currenttuning];
    _updateValues();
  }


  @override
  void didUpdateWidget(instrumentWidget oldWidget) {
    print(currenttuning);
    super.didUpdateWidget(oldWidget);
    _updateValues();
  }


  List<int> _buildscalenoteslist(int _root, int _currentscale) {
    List<int> scale = [];
    for (int i = 0; i < 7; i++) {
      scale.add((_root + scales[_currentscale][i]) % 12);
    }
    return scale;
  }

  List<int> _buildhighlights(int _root, int _currentscale,
      int _tonalhighlight) {
    List<int> _highlightnotes = [];
    for (int u = 0; u < 6; u += 2) {
      _highlightnotes.add(
          (_root + scales[_currentscale][_tonalhighlight + u]) % 12);
    }

    return _highlightnotes;
  }

  List<int> _buildchordnoteslist(int _root, int _currentchord) {
    List<int> _chordnotes = [];
    for (int u = 0; u < chords[_currentchord].length; u++) {
      _chordnotes.add((_root + chords[_currentchord][u]) % 12);
    }
    return _chordnotes;
  }

  void _updateValues() {
    setState(() {
      if (widget.rootnote == -1) {
        showall = true;
      }
      else if (widget.currentscale != -1) {
        showall = false;
        rootindex = scales[widget.currentscale].indexOf(widget.rootnote % 12);
        scalenotes = _buildscalenoteslist(widget.rootnote, widget.currentscale);
        chordnotes = _buildhighlights(
            widget.rootnote, widget.currentscale, widget.tonalhighlight);
      }
      else if (widget.currentchord != -1) {
        showall = false;
        chordnotes = _buildchordnoteslist(widget.rootnote, widget.currentchord);
        scalenotes = chordnotes;
      }
      else {
        showall = true;
      }
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

  Widget _buildFret(int fretnum, double fretwidth) {
    return new Container(
        width: fretwidth,
        decoration: BoxDecoration(
          color: Colors.brown[300],
          border: Border(
            left: BorderSide(color: Colors.black, width: 1.0),
            right: BorderSide(color: Colors.black, width: 1.0),
            bottom: BorderSide(color: Colors.white24, width: 1.0),
          ),
        ),
        child: Column(
            children: _buildNotes(fretnum, /*currenttuning,*/ fretwidth)
              ..add(
                Expanded(child: Center(
                  child: RichText(
                    text: TextSpan(
                      text: "$fretnum",
                      style: TextStyle(fontSize: 10.0,
                          color: Colors.black,
                          fontStyle: FontStyle.normal),
                    ), // TextSpan
                  ), // Rich Text))
                ),
                ),
              )));
  }

  List<Widget> _buildNotes(int fretnum, /*int tuning,*/ double fretwidth) {
    List<Widget> notes = [];
    for (int string = 0; string < 6; ++string) { // High e to low e
      // for (int string = 5; string>=0; --string) {
      int note = tunings[currenttuning][string] + fretnum;
      notes.add(
        guitarNoteWidget(
            note: note,
            string: string,
            fretwidth: fretwidth,
            inscale: showall ? true : scalenotes.contains(note % 12),
            inchord: showall ? false : chordnotes.contains(note % 12),
            fretsshown: fretsshown,
            scalepos: (showall || !scalenotes.contains(note % 12))
                ? null
                : scalenotes.indexOf(note % 12)
        ),
      );
    }
    return notes;
  }

  List<Widget> _buildKeys(double _screenwidth) {
    double keywidth = _screenwidth / keysshown;
    List<Widget> keys = [];
    for (int note = 0; note < 36; ++note) {
      keys.add(pianoKeyWidget(
        note: note % 12,
        inscale: showall ? true : scalenotes.contains(note % 12),
        inchord: showall ? false : chordnotes.contains(note % 12),
        keywidth: keywidth,
      )
      );
    }
    return keys;
  }

  @override
  Widget build(BuildContext context) {
    final double screen_width = MediaQuery
        .of(context)
        .size
        .width;
    return /*Stack(

      children: [
*/
      new Column(
        children: <Widget>[
          Container(
            height: 45.0,
            width: double.infinity,
            color: Colors.blue,
            child: Row(
              children: [
                IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      setState(() {
                        guitaron = !guitaron;
                      });
                    }
                ),
               guitaron ? new DropdownButton<String>(
                 isDense: true,
                 value: _tuning,
                  onChanged: (tuning) {
                    setState(() {
                      print(tuning);
                      _tuning = tuning;
                      currenttuning = _tunings.indexOf(tuning);
                    });
                  },
                  items: _tunings.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                ):Container(),
                Expanded(child: Container(),),
                guitaron ? Slider(
                  value: fretsshown.toDouble(),
                  min: 6.0,
                  max: 12.0,
                  divisions: 7,
                  label: '${fretsshown.round()}',
                  activeColor: Colors.white,
                  onChanged: (double newValue) {
                    setState(() {
                      fretsshown = newValue.floor();
                    });
                  },

                ) : Slider(
                  value: keysshown.toDouble(),
                  min: 10.0,
                  max: 24.0,
                  divisions: 15,
                  label: '${keysshown.round()}',
                  activeColor: Colors.white,
                  onChanged: (double newValue) {
                    setState(() {
                      keysshown = newValue.floor();
                    });
                  },

                )
              ],
            ),
          ),
          Container(
            height: guitaron ? 300.0 - (fretsshown - 6) * 20.0 : 300.0 -
                keysshown * 10.0,
            color: Colors.white,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: guitaron ? _buildFrets(screen_width) : _buildKeys(
                  screen_width),
            ),
          ),
          Expanded(child: Container(),)
        ],
      );
  }
}