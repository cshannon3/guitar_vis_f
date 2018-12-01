import 'dart:math';

import 'package:flutter/material.dart';
import 'package:guitar_vis_f/Component/input_options.dart';
import 'Component/instrument_widget.dart';



void main() => runApp(//new game_screen());//TestApp());
    new MaterialApp(
      title: "Music App",
      theme: new ThemeData.dark(),
      home: new homeScreen(),
      debugShowCheckedModeBanner: false,
    ));

class homeScreen extends StatefulWidget {
  @override
  _homeScreenState createState() => new _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {

  Widget instrumentwidget;

  @override
  void initState() {
    super.initState();
    setState(() {
      instrumentwidget = instrumentWidget();

    });
  }

  void onInputChanged(int _rootnote,int _currentchord , int _tonalhighlight, int _currentscale, int _currenttab) {

    setState(() {

      instrumentwidget = instrumentWidget(
        currentchord: _currentchord,
          rootnote:  _rootnote,
          tonalhighlight: _tonalhighlight,
          currentscale: _currentscale,
          currenttab: _currenttab,
          );

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

              ],
            ),
    ); //Material App
  }
}

