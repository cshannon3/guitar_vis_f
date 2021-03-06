import 'dart:math';

import 'package:flutter/material.dart';
import 'package:guitar_vis_f/Component/infinite_list.dart';
import 'package:guitar_vis_f/Component/radial_menu.dart';

import 'package:guitar_vis_f/shared_info.dart';


class InputOptions extends StatefulWidget {
  final Function(int rootnote, int currentchord,/*List<bool> notesShown,*/ int tonalhighlight, int _scale) onPressed;

  InputOptions({
    this.onPressed
});
  @override
  _InputOptionsState createState() => new _InputOptionsState();
}

class _InputOptionsState extends State<InputOptions> {

  List<String> _scales = <String>[
    '', 'Major', 'Minor', 'Harmonic', 'Melodic', "Blues"];
  String _scale = '';
  int currentscale = -1;
  int rootnote = 4;
  int tonalhighlight = 0;
  List<String> _chords = <String>[
    '', 'Major', 'Minor', '7', 'Major 7', 'sus2', 'sus4', 'dim'
  ];
  String _chord = "";
  int currentchord = -1;


  void onScalePressed(int scale, int note) {

    currentchord = -1;
    currentscale = scale;
    setState(() {
      print(scale);
      widget.onPressed(rootnote, currentchord,/*notesShown,*/ tonalhighlight, scale);
    });
  }

  void onChordPressed(int chord, int note) {

    setState(() {
      widget.onPressed(rootnote, currentchord,/*notesShown,*/ tonalhighlight, currentscale);
    });
  }


  void onPressed(int _tonalhighlight) {
    tonalhighlight = _tonalhighlight;
    setState(() {
      widget.onPressed(rootnote, currentchord,/*, notesShown*/ tonalhighlight, currentscale);
    });
  }

  void onNoteSelected(int _rootnote) {
    rootnote = _rootnote;
    _scale != '' ?
    onScalePressed(currentscale, rootnote)
        : onChordPressed(currentchord, rootnote);
  }

  void showAll() {
   /* for (int m = 0; m < notesShown.length; m++) {
      notesShown[m] = true;
    }*/
    _scale = '';
    rootnote = -1;
    currentscale = -1;
    currentchord = -1;

    setState(() {
      widget.onPressed(rootnote/*, notesShown,*/, currentchord, tonalhighlight, currentscale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0, vertical: 50.0),
            child: Column(
              children: <Widget>[
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
                          currentscale = _scales.indexOf(_scale) - 1;
                          if (currentscale >= 0) {
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
                ) : Container(), // Input Decorator
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
                          currentchord = _chords.indexOf(_chord) - 1;
                          if (currentchord >= 0) {
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
                ) : Container(),
                _scale != '' || _chord != '' ?
                  InfiniteList(
                    rootnote: rootnote,
                    onPressed: onNoteSelected,
                  ) : Container(),
              ],
            ),
          ), // Expanded
          _scale != '' ? RadialMenu(
            anchor: Offset(200.0, 350.0),
            onPressed: onPressed,
            rootnote: rootnote,
          ) : Container(),
        ]
    );
  }
}

