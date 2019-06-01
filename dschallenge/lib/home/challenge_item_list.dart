import 'package:dschallenge/models/challenge_item.dart';
import 'package:flutter/material.dart';

import '../detail_screen.dart';

class ChallengeItemList extends StatelessWidget {
  List<Color> colors = const [
    Colors.blue,
    Colors.teal,
    Colors.pink,
    Colors.purple,
    Colors.red
  ];
  final ChallengeItem _item;
  final int _index;

  ChallengeItemList(this._item, this._index);

  @override
  Widget build(BuildContext context) {
    final cell = _index % 2 == 0 ? _rowWithLeftImage() : _rowWithRightImage();
    return InkWell(
      onTap: () {
        _openDetail(context, _item);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        height: 250,
        child: cell,
      ),
    );
  }

  Widget _rowWithLeftImage() {
    return Row(
      children: <Widget>[
        _rowImage(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: _details(),
          ),
        )
      ],
    );
  }

  Widget _rowWithRightImage() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: _details(),
          ),
        ),
        _rowImage(),
      ],
    );
  }

  Widget _rowImage() {
    return Stack(
      children: <Widget>[
        Container(
          width: 160,
          color: Colors.black12,
        ),
        Container(
          width: 160,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(_item.imageUrl), fit: BoxFit.fitHeight)),
        ),
      ],
    );
  }

  Widget _details() {
    return Column(
      children: <Widget>[
        _divider(),
        _title(),
        _description(),
        _tags(),
        _divider(),
      ],
    );
  }

  Widget _divider() {
    return Expanded(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 1,
              color: Colors.black12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _title() {
    return Container(
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          _item.title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _description() {
    return Container(
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          _item.desc,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget _tags() {
    List<String> individualTags = _item.tags.split(",");
    List<Widget> tags = [];
    for (int index = 0; index < individualTags.length; index++) {
      tags.add(_coloredBox(individualTags[index], index));
    }

    return Container(
      padding: const EdgeInsets.only(left: 4),
      alignment: Alignment.bottomLeft,
      child: Wrap(
        children: tags,
      ),
    );
  }

  Widget _coloredBox(String text, int index) {
    final pos = index % colors.length;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colors[pos],
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void _openDetail(BuildContext context, ChallengeItem _item) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => DetailScreen(item: _item)));
  }
}
