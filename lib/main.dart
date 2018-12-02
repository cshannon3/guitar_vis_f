import 'dart:math';

import 'package:flutter/material.dart';
import 'package:guitar_vis_f/Component/infinite_list.dart';
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
  //int tuning = 0;
  String _tonalnum;
  int currenttonal = 0;
  String _scale = '';
  int currentscale = 0;
  int chord = 0;
  int rootnote = 2;

  @override
  void initState() {
    super.initState();
    currenttonal = 0;
    setState(() {
      _tonalnum = tonalnames[0];
      instrumentwidget = instrumentWidget(
        rootnote: rootnote,
        currentchord: 0,
      );
    });
  }

  List<Widget> _buildkey(int _root, int _currentscale) {
    List<Widget> keysymbols = [];
    List<int> scale = buildscalenoteslist(_root, _currentscale);
    List<int> sharpnotation = [1, 2, 4, 6, 7, 9, 11];
    int sharpnum = 0;
    print(scale);
    bool nextrow = false;
    // if (sharpnotation.contains(_root)) {
    scale.forEach((val) {
      if (sharps.contains(val)) {
        // getLines(val, true).forEach((_linespace) {
        // if()
        if (!nextrow && val > (_root + 5) % 12) {
          sharpnum = -1;
          nextrow = true;
        }
        List<int> lines = getLines(val, true);
        print(lines.last);
        bool sharpformat = sharpnotation.contains(_root);
        int notaline = ((!sharpformat && lines.last > 17) || lines.last > 18)
            ? lines[lines.length - 2]
            : lines.last;

        if (!sharpformat) notaline += 1;

        keysymbols.add(Positioned(
            bottom: (sharpformat)
                ? 60.0 + 10.0 * notaline - 5.0
                : 60.0 + 10.0 * notaline + 2.0,
            left: 65.0 + sharpnum * 10.0,
            child: Container(
              height: 30.0,
              width: 30.0,
              child: (sharpformat)
                  ? Image.asset("assets/images/sharp.png")
                  : Image.asset("assets/images/flat.png"),
            )));
        //});
        sharpnum += 2;
      }
    });
    /* } else if (_root != 0) {
      // flat notation

    }*/

    return keysymbols;
  }

  List<Widget> _buildnotes(int _root, int _currenttonal) {
    List<Widget> notes = [];
    List<int> chordnums = buildhighlights(_root, 0, _currenttonal); //[1, 5, 8];
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
                    border: Border.all(
                        color: Colors.black,
                        width: (_linespace / 7).floorToDouble())),
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
            padding: const EdgeInsets.only(top: 30.0),
            child: Container(
              height: 45.0,
              width: double.infinity,
              color: Colors.blue,
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () {
                        setState(() {
                          // guitaron = !guitaron;
                        });
                      }),
                  new DropdownButton<String>(
                    isDense: true,
                    value: _tonalnum,
                    onChanged: (tonalnum) {
                      setState(() {
                        _tonalnum = tonalnum;
                        currenttonal = tonalnames.indexOf(tonalnum);
                        onInputChanged(
                            rootnote, -1, currenttonal, currentscale, -1);
                      });
                    },
                    items: tonalnames.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                  ),
                  Expanded(
                      child: InfiniteList(
                          rootnote: rootnote,
                          onPressed: (int _rootnote) {
                            setState(() {
                              print(_rootnote);
                              rootnote = _rootnote;
                              onInputChanged(
                                  rootnote, -1, currenttonal, currentscale, -1);
                            });
                          })),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
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
                ]
                  ..addAll(_buildnotes(rootnote, currenttonal))
                  ..addAll(_buildkey(rootnote, 0)),
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
