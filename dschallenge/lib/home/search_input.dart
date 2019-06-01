import 'package:dschallenge/home/query_provider.dart';
import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final QueryProvider _query;
  final _queryTextController = TextEditingController();

  SearchInput(this._query);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black12)),
        child: Row(
          children: <Widget>[
            _searchIcon(),
            Expanded(child: _queryInput()),
          ],
        ),
      ),
    );
  }

  Widget _searchIcon() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 16),
      child: Icon(
        Icons.search,
        color: Colors.black54,
      ),
    );
  }

  Widget _queryInput() {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextField(
        controller: _queryTextController,
        onSubmitted: (text) {
          _query.query = text;
        },
      ),
    );
  }
}
