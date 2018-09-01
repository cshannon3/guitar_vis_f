import 'package:flutter/material.dart';
import '../fluttery/gestures.dart';

import '../fluttery/layout.dart';
import 'dart:math';
import 'package:guitar_vis_f/shared_info.dart';
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
  final int rootnote;

  RadialMenu({
    this.anchor,
    this.onPressed,
    this.rootnote,
  });


  @override
  _RadialMenuState createState() => new _RadialMenuState();
}


class _RadialMenuState extends State<RadialMenu> {

  int rootnote;

  @override
  void initState() {
    super.initState();
    rootnote = widget.rootnote;
  }
  List<Widget> _buildRoundButtons() {
    List<PolarPosition> buttons = [];
    List<String> names = ["(I)", "m(ii)", "m(iii)", "(IV)", "(V)", "m(vi)"/*, "vii"*/];
    List<PolarCoord> coords = [PolarCoord(-pi/2, 120.0),PolarCoord(-pi/2 + (pi /4), 80.0), PolarCoord(-pi/2 + (7* pi /4), 80.0),PolarCoord(-pi/2+ (7*pi/4), 140.0),
    PolarCoord(-pi/2+ (pi/4), 140.0),PolarCoord(-pi/2, 60.0)];
    for(int i = 0; i<names.length;++i){
      buttons.add(_buildRoundButton(names[i], coords[i], i));
    }
    return buttons;

  }

  Widget _buildRoundButton(String name, PolarCoord coord, int index) {

    return PolarPosition(
      origin: widget.anchor,
      coord: coord,
      child:  GestureDetector(
        onTap:  (){widget.onPressed(index);},
        child: new Container(
            width: 55.0,
            height: 55.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: getColor(((widget.rootnote+majorscale[index])%12).toDouble()),
            ), // Box Decoration
            child: Center(child: RichText(text: TextSpan(text: "${notenames[(widget.rootnote+majorscale[index])%12]}$name"),))
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: <Widget>[
        CenterAbout(
          position: widget.anchor,
          child: FlatButton(onPressed: (){widget.onPressed(0);},
              child: RichText(text: TextSpan(text: "${notenames[(widget.rootnote+majorscale[0])%12]}(I)"),)
          ),
        ), // CenterAbout
      ]
        ..addAll(_buildRoundButtons()),

    );
  }
}

