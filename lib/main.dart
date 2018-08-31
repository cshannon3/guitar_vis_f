import 'dart:math';

import 'package:flutter/material.dart';
import 'fluttery/gestures.dart';
import 'package:guitar_vis_f/Component/guitar_widget.dart';
import 'fluttery/layout.dart';
import 'package:guitar_vis_f/Component/piano_widget.dart';
import 'package:guitar_vis_f/Component/infinite_list.dart';

List<String> notenames = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B" ];
List<int> sharps = [49, 51 ,54,56, 58, 61 , 63, 66, 68, 70];
//List<int> rootnotes = [0, 5, 10, 15, 19, 24];
//  low E, A, D, G, B, high E
List<List<int>> scales = [[0,2,4,5,7,9,11,12], // major Scale
[0,2,3,5,7,8,10,12], // minor Scale
[0,2,3,5,7,8,11,12], // harmonic
[0,2,3,5,7,9,11,12], // melodic
[0,2,3,5,6,7,11,12]  // Blues scale
];
List<List<int>> chords = [[0, 4, 7],// major chord
[0, 3, 7], // minor chord
[0, 4, 7, 10], // 7
[0, 4, 7, 11], // maj7
[0, 2, 7], // sus2
[0, 5, 7], // sus4
[0, 3, 6, 9] // dim
];
void main() => runApp(//new game_screen());//TestApp());
    new MaterialApp(
      title: "Music App",
      theme: new ThemeData.dark(),
      home: new homeScreen(),
    ));


class homeScreen extends StatefulWidget {
  @override
  _guitarScreenState createState() => new _guitarScreenState();
}

class _guitarScreenState extends State<homeScreen> {

  Widget guitarwidget, pianowidget;
  List<bool> octavesShown = [true,true,true,true];
  List<bool> notesShown = [true,true,true,true,true,true,true,true,true,true,true,true];
  List<String> _scales = <String>['', 'Major', 'Minor', 'Harmonic', 'Melodic', "Blues"];
  String _scale = '';
  int currentscale = 0;
  int rootnote = 4;
  int currenttuning = 0;
  List<String> _chords = <String>['', 'Major', 'Minor', '7', 'Major 7', 'sus2', 'sus4', 'dim'];
  String _chord = "";
  int currentchord = 0;
  bool guitarOn = true;



  @override
  void initState() {
    super.initState();
    setState(() {
      guitarwidget = guitarWidget(rootnote: rootnote,);
      pianowidget = pianoWidget();
    });

  }



  void onOctavePressed(int octave) {
    octavesShown[octave] = !octavesShown[octave];
    setState(() {
      guitarwidget = guitarWidget(octavesShown: octavesShown,notesShown: notesShown, tuning: currenttuning,);
    });
  }
  // Just for E right now to test it out
  void onScalePressed(int scale, int note){
    for (int m = 0; m < notesShown.length; m++) {
      int c = (m-note<0) ? 12 + (m-note) : m-note;
      if (scales[scale].contains(c)) {
        notesShown[m] = true;
      } else{
        notesShown[m] = false;
      }
    }
    setState(() {
      guitarwidget = guitarWidget(octavesShown: octavesShown,notesShown: notesShown,tuning: currenttuning,rootnote:  rootnote,);
      pianowidget = pianoWidget(notesShown: notesShown,rootnote:  rootnote,);
    });
  }
  void onChordPressed(int chord, int note){
    for (int m = 0; m < notesShown.length; m++) {
      int c = (m-note<0) ? 12 + (m-note) : m-note;
      if (chords[chord].contains(c)) {
        notesShown[m] = true;
      } else{
        notesShown[m] = false;
      }
    }
    setState(() {
      guitarwidget = guitarWidget(octavesShown: octavesShown,notesShown: notesShown,tuning: currenttuning,rootnote:  rootnote,);
      pianowidget = pianoWidget(notesShown: notesShown,rootnote:  rootnote,);
    });
  }

  void onNotePressed(int note) {
    notesShown[note] = !notesShown[note];
    setState(() {
      guitarwidget = guitarWidget(octavesShown: octavesShown,notesShown: notesShown,tuning: currenttuning, rootnote: rootnote,);
      pianowidget = pianoWidget(notesShown: notesShown,rootnote:  rootnote,);
    });

  }
  void onPressed(int tonalhighlight) {
    setState(() {
      guitarwidget = guitarWidget(octavesShown: octavesShown,notesShown: notesShown,tuning: currenttuning, rootnote: rootnote, tonalhighlight: tonalhighlight,);
      pianowidget = pianoWidget(notesShown: notesShown,rootnote:  rootnote, tonalhighlight: tonalhighlight,);
    });
  }

  void onNoteSelected(int _rootnote) {
    _scale != '' ?
    onScalePressed(currentscale, rootnote)
        : onChordPressed(currentchord, rootnote);
  }

  void showAll() {
    for (int m = 0; m < notesShown.length; m++) {
      notesShown[m] = true;
      if (m < octavesShown.length)  {
        octavesShown[m] = true;
      }
    }
    _scale = '';

//TODO only update the widget that is showing and update other widget only if it becomes the present widget
    setState(() {
      guitarwidget = guitarWidget(octavesShown: octavesShown,notesShown: notesShown, tuning: currenttuning,);
      pianowidget = pianoWidget(notesShown: notesShown,);
    });

  }
  List<Widget> _buildOctaveBar() {
    List<Widget> octaveBar = [];
    for (int i = 0; i < octavesShown.length; ++i) {
      octaveBar.add(RaisedButton(
        onPressed: (){onOctavePressed(i);},
        child: RichText(
          text: TextSpan(
            text: "$i",
          ), // Text Span
        ), // RichText

      ), // Raised Button)
      );
    }
    return octaveBar;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 50.0),
            child: Column(
              children: <Widget>[
               /* Text("Octaves"),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _buildOctaveBar()
                ), // Row
                new InputDecorator(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.library_music),
                    labelText: 'Tuning',
                  ),
                  isEmpty: _tuning == 'E',
                  child: new DropdownButtonHideUnderline(
                    child: new DropdownButton<String>(
                      value: _tuning,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          // newContact.favoriteColor = newValue;
                          _tuning = newValue;
                          currenttuning = _tunings.indexOf(_tuning);

                          showAll();
                        });
                      },
                      items: _tunings.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                    ), // Dropdown Button
                  ), // DropdownButtonHideUnderline
                ), // Input Decorator*/
                _chord == '' ? new InputDecorator(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.library_music),
                    labelText: 'Scale',
                  ),
                  isEmpty: _scale == '',
                  child: new DropdownButtonHideUnderline(
                    child: new DropdownButton<String>(
                      value: _scale,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          // newContact.favoriteColor = newValue;
                          _scale = newValue;
                          currentscale = _scales.indexOf(_scale)-1;
                          if(currentscale >= 0) {
                            onScalePressed(currentscale, rootnote);
                          } else {
                            showAll();
                          }
                        });
                      },
                      items: _scales.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                    ), // Dropdown Button
                  ), // DropdownButtonHideUnderline
                ): Container(), // Input Decorator
                _scale == '' ? new InputDecorator(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.music_note),
                    labelText: 'Chord',
                  ),
                  isEmpty: _chord == '',
                  child: new DropdownButtonHideUnderline(
                    child: new DropdownButton<String>(
                      value: _chord,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          // newContact.favoriteColor = newValue;
                          _chord = newValue;
                          currentchord = _chords.indexOf(_chord)-1;
                          if(currentchord >= 0) {
                            onChordPressed(currentchord, rootnote);
                          } else {
                            showAll();
                          }
                        });
                      },
                      items: _chords.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                    ), // Dropdown Button
                  ), // DropdownButtonHideUnderline
                ): Container(),
                /*_scale != '' || _chord != '' ? new InputDecorator(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.music_note),
                    labelText: 'RootNote',
                  ),
                  isEmpty: _rootname == 'E',
                  child: new DropdownButtonHideUnderline(
                    child: new DropdownButton<String>(
                      value: _rootname,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          // newContact.favoriteColor = newValue;
                          _rootname = newValue;
                          rootnote = notenames.indexOf(_rootname);
                          _scale != '' ?
                          onScalePressed(currentscale, rootnote)
                              : onChordPressed(currentchord, rootnote);
                        });
                      },
                      items: notenames.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                    ), // Dropdown Button
                  ), // DropdownButtonHideUnderline
                ) : Container(), // Input Decorator*/
              _scale != '' || _chord != '' ? InfiniteList(rootnote: rootnote, onPressed: onNoteSelected,): Container(),



              ] ,
              //mainAxisAlignment: MainAxisAlignment.center,
            ),
          ), // Expanded
          RadialMenu(
            anchor: Offset(200.0, 350.0),
            onPressed: onPressed,
    ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.print),
                  onPressed: () {
                      setState(() {
                        guitarOn = !guitarOn;
                      });
                  },

                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: Container(
                    height: 300.0,
                    child: guitarOn ? guitarwidget : pianowidget,

                  ),
                ),
              ],
            ),
          ), // Center

        ],
      ), // Padding
    ); //Material App
  }
}

class PolarPosition extends StatelessWidget {
  final Offset origin;
  final PolarCoord coord;
  final Widget child;

  PolarPosition({
    this.origin = const Offset(0.0, 0.0),
    this.coord,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final radialPosition = Offset(
      origin.dx  + (cos(coord.angle)*coord.radius),
      origin.dy + (sin(coord.angle)* coord.radius),
    );
    return CenterAbout(
      position: radialPosition,
      child: child,
    );
  }
}
class AnchoredRadialMenu extends StatefulWidget {
  final Widget child;

  AnchoredRadialMenu({
    this.child,
});
  @override
  _AnchoredRadialMenuState createState() => new _AnchoredRadialMenuState();
}

class _AnchoredRadialMenuState extends State<AnchoredRadialMenu> {
  @override
  Widget build(BuildContext context) {
    return new AnchoredOverlay(
      showOverlay: true,
      overlayBuilder: (BuildContext context, Offset anchor) {
        return RadialMenu(
          anchor: anchor,
        );
      },
    );
  }
}


class RadialMenu extends StatefulWidget {
  final Offset anchor;
  final Function(int tonalhighlight) onPressed;

  RadialMenu({
    this.anchor,
  this.onPressed,
  });


  @override
  _RadialMenuState createState() => new _RadialMenuState();
}


class _RadialMenuState extends State<RadialMenu> {
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: <Widget>[
        CenterAbout(
           position: widget.anchor,
          child: FlatButton(onPressed: (){widget.onPressed(0);},
              child: RichText(text: TextSpan(text: "I"),)
          ),
        ), // CenterAbout
        PolarPosition(
          origin: widget.anchor,
          coord: PolarCoord(-pi/2, 50.0),
          child:  FlatButton(onPressed: (){widget.onPressed(5);},
              child: RichText(text: TextSpan(text: "vi"),)
          ),
        ),
        PolarPosition(
          origin: widget.anchor,
          coord: PolarCoord(-pi/2, 100.0),
          child:  FlatButton(onPressed: (){widget.onPressed(0);},
              child: RichText(text: TextSpan(text: "I"),)
          ),
        ),
        PolarPosition(
          origin: widget.anchor,
          coord: PolarCoord(-pi/2 + (pi /4), 60.0),
          child:  FlatButton(onPressed: (){widget.onPressed(1);},
              child: RichText(text: TextSpan(text: "ii"),)
          ),
        ),
        PolarPosition(
          origin: widget.anchor,
          coord: PolarCoord(-pi/2+ (pi/4), 120.0),
          child:  FlatButton(onPressed: (){widget.onPressed(4);},
              child: RichText(text: TextSpan(text: "V"),)
          ),
        ),
        PolarPosition(
          origin: widget.anchor,
          coord: PolarCoord(-pi/2 + (7* pi /4), 60.0),
          child: FlatButton(onPressed: (){widget.onPressed(2);},
              child: RichText(text: TextSpan(text: "iii"),)
          ),
        ),
        PolarPosition(
          origin: widget.anchor,
          coord: PolarCoord(-pi/2+ (7*pi/4), 120.0),
          child: FlatButton(onPressed: (){widget.onPressed(3);},
              child: RichText(text: TextSpan(text: "IV"),)
          ),
        ),
      ],

    );
  }
}
