import 'dart:math';

import 'package:flutter/material.dart';
import 'package:guitar_vis_f/Component/input_options.dart';
import 'package:guitar_vis_f/Component/guitar_widget.dart';
import 'package:guitar_vis_f/Component/piano_widget.dart';



void main() => runApp(//new game_screen());//TestApp());
    new MaterialApp(
      title: "Music App",
      theme: new ThemeData.dark(),
      home: new homeScreen(),
    ));

class homeScreen extends StatefulWidget {
  @override
  _homeScreenState createState() => new _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {

  Widget guitarwidget, pianowidget;
  List<bool> notesShown = [true,true,true,true,true,true,true,true,true,true,true,true];

  int currentscale = 0;
  int rootnote = 4;
  int currentchord = 0;
  bool guitarOn = true;
  int tonalhighlight = 0;


  @override
  void initState() {
    super.initState();
    setState(() {
      guitarwidget = guitarWidget(rootnote: rootnote,);
      pianowidget = pianoWidget();
    });
  }

  void onInputChanged(int _rootnote, List<bool> _notesShown, int _tonalhighlight, int _currentscale) {

    setState(() {
      notesShown = _notesShown;
      rootnote = _rootnote;
      tonalhighlight = _tonalhighlight;
      currentscale = _currentscale;
      guitarwidget = guitarWidget(
          notesShown: notesShown,
          rootnote:  rootnote,
          tonalhighlight: _tonalhighlight,
          currentscale: currentscale,);
      pianowidget = pianoWidget(
          notesShown: notesShown,
          rootnote:  rootnote,
          tonalhighlight: _tonalhighlight,
          currentscale: currentscale,);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Stack(
        children: <Widget>[
          InputOptions(rootnote: rootnote, onPressed: onInputChanged,),
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
                  child:  guitarOn ? guitarwidget : pianowidget,
                ),
              ],
            ),
          ), // Center

        ],
      ), // Padding
    ); //Material App
  }
}

