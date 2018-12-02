import 'dart:math';

import 'package:flutter/material.dart';
import 'package:guitar_vis_f/Component/input_options.dart';
import 'Component/instrument_widget.dart';
import 'package:guitar_vis_f/shared_info.dart';

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
      instrumentwidget = instrumentWidget(
        rootnote: 1,
        currentchord: 0,
      );
    });
  }

  List<Widget> _buildnotes() {
    List<Widget> notes = [];
    List<int> chordnums = [1, 5, 8];
    chordnums.forEach((_c) {
      bool sharp = sharps.contains(_c);
      getLines(_c, sharp).forEach((_linespace) {
        notes.add(Positioned(
            bottom: 60.0 + 10.0 * _linespace,
            left: 180.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Container(
                height: 12.0,
                width: 13.0,
                decoration: BoxDecoration(
                    color: getColor(_c.toDouble()), //shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.black, width: 2.0)),
              ),
            )));
        if (sharp) {
          notes.add(Positioned(
              bottom: 60.0 + 10.0 * _linespace,
              left: 180.0 - 15.0,
              child: Container(
                height: 20.0,
                width: 20.0,
                child: Image.asset("assets/images/sharp.png"),
              )));
        }
      });
    });
    return notes;
  }

  List<int> getLines(int _note, bool _sharp) {
    List<int> lines = [];
    bool additionalnote = (_note >= 5); // need to keep track of sharps
    int start = (_note < 4) ? _note + 12 : _note; // start with low e string
    while (start < 35) {
      int missedsharps = 2 * (start / 12).floor();
      if (additionalnote) missedsharps += 1;
      lines.add(((start + missedsharps) / 2).floor());
      start += 12;
    }
    return lines;
  }

  void onInputChanged(int _rootnote, int _currentchord, int _tonalhighlight,
      int _currentscale, int _currenttab) {
    setState(() {
      instrumentwidget = instrumentWidget(
        currentchord: _currentchord,
        rootnote: _rootnote,
        tonalhighlight: _tonalhighlight,
        currentscale: _currentscale,
        currenttab: _currenttab,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 60.0, bottom: 30.0),
            child: Container(
              height: 300.0,
              width: 800.0,
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(11, (i) {
                      return Container(
                        height: 20.0,
                        width: 700.0,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: (i != 5)
                                        ? Colors.black
                                        : Colors.white))),
                      );
                    }),
                  ),
                  /* Padding(
                    padding: const EdgeInsets.only(top: 70.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 100.0,
                          width: 80.0,
                          child: Image.asset(
                            "assets/images/clef.png",
                          ),
                        ),
                        Expanded(child: Container()),
                        Container(
                          padding: EdgeInsets.only(top: 40.0),
                          height: 90.0,
                          width: 80.0,
                          child: Image.asset(
                            "assets/images/bass.png",
                          ),
                        ),
                        Expanded(child: Container())
                      ],
                    ),
                  ),*/
                  Positioned(
                      top: 60.0,
                      left: 5.0,
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 200.0,
                            width: 2.0,
                            color: Colors.black,
                          ),
                          Container(
                            height: 200.0,
                            width: 150.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  height: 100.0,
                                  width: 80.0,
                                  child: Image.asset(
                                    "assets/images/clef.png",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                // Expanded(child: Container()),
                                Container(
                                  padding: EdgeInsets.only(top: 30.0),
                                  height: 90.0,
                                  width: 80.0,
                                  child: Image.asset(
                                    "assets/images/bass.png",
                                  ),
                                ),
                                //Expanded(child: Container())
                              ],
                            ),
                          ),
                          Container(
                            height: 200.0,
                            width: 2.0,
                            color: Colors.black,
                          ),
                          Container(
                            height: 200.0,
                            width: 140.0,
                          ),
                          Container(
                            height: 200.0,
                            width: 2.0,
                            color: Colors.black,
                          ),
                        ],
                      )),
                  /*  Positioned(
                      bottom: 70.0,
                      left: 270.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Container(
                          height: 12.0,
                          width: 13.0,
                          decoration: BoxDecoration(
                              color: Colors.blue, //shape: BoxShape.circle,
                              borderRadius: BorderRadius.circular(20.0),
                              border:
                                  Border.all(color: Colors.black, width: 3.0)),
                        ),
                      )),
                  Positioned(
                      bottom: 60.0,
                      left: 240.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Container(
                          height: 12.0,
                          width: 13.0,
                          decoration: BoxDecoration(
                              color: Colors.blue, //shape: BoxShape.circle,
                              borderRadius: BorderRadius.circular(20.0),
                              border:
                                  Border.all(color: Colors.black, width: 3.0)),
                        ),
                      )),
                  Positioned(
                      bottom: 70.0,
                      left: 210.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Container(
                          height: 12.0,
                          width: 13.0,
                          decoration: BoxDecoration(
                              color: Colors.blue, //shape: BoxShape.circle,
                              borderRadius: BorderRadius.circular(20.0),
                              border:
                                  Border.all(color: Colors.black, width: 3.0)),
                        ),
                      )),
                  Positioned(
                      bottom: 70.0,
                      left: 180.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Container(
                          height: 12.0,
                          width: 13.0,
                          decoration: BoxDecoration(
                              color: Colors.blue, //shape: BoxShape.circle,
                              borderRadius: BorderRadius.circular(20.0),
                              border:
                                  Border.all(color: Colors.black, width: 3.0)),
                        ),
                      )),
                  Positioned(
                      bottom: 70.0,
                      left: 165.0,
                      child: Container(
                        height: 20.0,
                        width: 20.0,
                        child: Image.asset("assets/images/sharp.png"),
                      )),
                  Positioned(
                      bottom: 70.0,
                      left: 195.0,
                      child: Container(
                        height: 20.0,
                        width: 20.0,
                        child: Image.asset("assets/images/sharp.png"),
                      )),
                      */
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 10.0),
                    child: Column(
                      children: List.generate(26, (p) {
                        return Container(
                          height: 10.0,
                          width: 10.0,
                          child: Text(
                            " ${clefnotes[p % clefnotes.length]}",
                            style: TextStyle(
                              fontSize: 10.0,
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.green, shape: BoxShape.circle),
                        );
                      }),
                    ),
                  )
                ]..addAll(_buildnotes()),
              ),
            ),
          ),
          Expanded(
            child: instrumentwidget,
          ),
        ],
      ),
    )
        /*Column(
        children: <Widget>[
          Expanded(
        child:
          InputOptions(onPressed: onInputChanged,),
    ),
          Expanded(
            child: instrumentwidget,
          ),

              ],
            ),*/
        ); //Material App
  }
}

List<String> clefnotes = [
  "C",
  "B",
  "A",
  "G",
  "F",
  "E",
  "D",
];
