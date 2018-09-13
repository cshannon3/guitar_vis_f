import 'dart:math';

import 'package:flutter/material.dart';
import 'package:guitar_vis_f/Component/infinite_list.dart';
import 'package:guitar_vis_f/Component/radial_menu.dart';

import 'package:guitar_vis_f/shared_info.dart';


class InputOptions extends StatefulWidget {
  final Function(int rootnote, int currentchord, int tonalhighlight, int _scale) onPressed;

  InputOptions({
    this.onPressed
});
  @override
  _InputOptionsState createState() => new _InputOptionsState();
}

class _InputOptionsState extends State<InputOptions> {



  String _scale = '';
  int currentscale = -1;
  int rootnote = 4;
  int tonalhighlight = 0;

  String _chord = "";
  int currentchord = -1;


  void onChanged() {
    setState(() {
      widget.onPressed(rootnote, currentchord,tonalhighlight, currentscale);
    });
  }

  void showAll() {
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
            padding: EdgeInsets.only(
                left: 8.0,right: 8.0,  top: 50.0, bottom: _scale!=-1 ? 200.0: 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          _scale = newValue;
                          currentscale = scalenames.indexOf(_scale) - 1;
                          if (currentscale >= 0) {
                            onChanged();
                          } else {
                            showAll();
                          }
                        });
                      },
                      items: scalenames.map((String value) {
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
                          _chord = newValue;
                          currentchord = chordnames.indexOf(_chord) - 1;
                          if (currentchord >= 0) {

                            onChanged();
                          } else {
                            showAll();
                          }
                        });
                      },
                      items: chordnames.map((String value) {
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
                    onPressed: (int _rootnote){
                      setState(() {
                        rootnote = _rootnote;
                        onChanged();
                      });
                    }

                  ) : Container(),
              ],
            ),
          ), // Expanded
          _scale != '' ? Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: RadialMenu(
              anchor: Offset(200.0, 350.0),
              rootnote: rootnote,
              onPressed: (int _tonalhighlight) {
                setState(() {
                  tonalhighlight = _tonalhighlight;
                  onChanged();
                });
              }
            ),
          ) : Container(),
        ]
    );
  }
}

