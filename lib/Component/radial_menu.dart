import 'package:flutter/material.dart';
import '../fluttery/gestures.dart';

import '../fluttery/layout.dart';
import 'dart:math';

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

