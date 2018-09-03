import 'package:flutter/material.dart';
import 'package:guitar_vis_f/shared_info.dart';
class InfiniteList extends StatefulWidget {
  final int rootnote;
  final Function(int rootnote) onPressed;
  InfiniteList({
    this.rootnote,
    this.onPressed,
  });

  @override
  _InfiniteListState createState() => new _InfiniteListState();
}

class _InfiniteListState extends State<InfiniteList> {
  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;
  bool loadingnotes = true;
  List<Widget> noteButtons;
  int rootnote;

  @override
  void initState() {
    rootnote = widget.rootnote;
    setState(() {
      noteButtons = _buildNoteButtons();
    });
    setState(() {
      loadingnotes = false;
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _getMoreData();

      }
    });
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _getMoreData() async {
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);
      setState(() {
        noteButtons.addAll(noteButtons.sublist(0, 11));
        isPerformingRequest = false;
      });
    }
  }

  List<Widget> _buildNoteButtons() {
    List<Widget> noteButtons = [];
    for (int o = 0; o < notenames.length; ++o) {
      noteButtons.add(_buildNoteButton(o, rootnote==o));
    }

    return noteButtons;
  }

  Widget _buildNoteButton(int note, bool isSelected){
    return GestureDetector(
      onTap: (){
        setState(() {
          rootnote = note;
          widget.onPressed(rootnote);
          loadingnotes =true;
          noteButtons = _buildNoteButtons();
        });
        setState(() {
          loadingnotes = false;
        });
      },
      child: Container(
          height: 40.0,
          width: 50.0,
          decoration: BoxDecoration(
            color: getColor((note % 12).toDouble()),
            shape: BoxShape.circle,
            border: isSelected ? new Border.all(
              color: (sharps.contains(note % 12)) ? Colors.white : Colors
                  .black,
              width: 2.5,
            ) : Border(),

          ),

            child: Center(
              child: RichText(
                  text: TextSpan(
                      text: notenames[note])
              ),
            ),
          )
      //),
    );
  }



  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){},
        ),
        Expanded(child: Container(
          height: 50.0,

          decoration: BoxDecoration(
            color: Colors.grey[600],
            border: Border(
              left: BorderSide(color: Colors.grey, width: 1.0),
              right: BorderSide(color: Colors.grey, width: 1.0),
              bottom: BorderSide(color: Colors.white24, width: 1.0),
              top: BorderSide(color: Colors.white24, width: 1.0),
            ), // Border
          ), // BoxDecoration
          child: loadingnotes ? Container() : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: noteButtons.length,
            itemBuilder: (context, index) {
              return noteButtons[index];
            },
            controller: _scrollController,
          ),
        ),
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward_ios),
          onPressed: (){},
        ),
      ],
    );
  }
}
