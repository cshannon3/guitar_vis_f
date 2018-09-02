import 'dart:math';

import 'package:flutter/material.dart';
import 'package:guitar_vis_f/Component/input_options.dart';
import 'package:guitar_vis_f/Component/guitar/guitar_widget.dart';
import 'package:guitar_vis_f/Component/piano_widget.dart';
import 'Component/instrument_widget.dart';



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

  Widget instrumentwidget;//, guitarwidget, pianowidget;
  //List<bool> notesShown = [true,true,true,true,true,true,true,true,true,true,true,true];
/*
  int currentscale = -1;
  int rootnote = -1;
  int currentchord = 0;
  bool guitarOn = true;
  int tonalhighlight = 0;
*/

  @override
  void initState() {
    super.initState();
    setState(() {
      instrumentwidget = instrumentWidget();
    //  guitarwidget = guitarWidget();
    //  pianowidget = pianoWidget();
    });
  }

  void onInputChanged(int _rootnote,int _currentchord /*List<bool> _notesShown*/, int _tonalhighlight, int _currentscale) {

    setState(() {
      //notesShown = _notesShown;
     /* rootnote = _rootnote;
      tonalhighlight = _tonalhighlight;
      currentscale = _currentscale;
      currentchord = _currentchord;*/
      instrumentwidget = instrumentWidget(
          //notesShown: notesShown,
        currentchord: _currentchord,
          rootnote:  _rootnote,
          tonalhighlight: _tonalhighlight,
          currentscale: _currentscale,
          );
     /* pianowidget = pianoWidget(
         // notesShown: notesShown,
        currentchord: _currentchord,
          rootnote:  _rootnote,
          tonalhighlight: _tonalhighlight,
          currentscale: _currentscale,);*/
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
        children: <Widget>[
          Expanded(
        child:
          InputOptions(onPressed: onInputChanged,),
    ),
          Expanded(
            child: instrumentwidget,
          ),
          /*Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.print),
                  onPressed: () {
                      setState(() {
                        //guitarOn = !guitarOn;
                      });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child:  /*guitarOn ?*/instrumentwidget /*: pianowidget*/,
                ),*/
              ],
            ),
        //  ), // Center

       // ],
     // ), // Padding
    ); //Material App
  }
}

