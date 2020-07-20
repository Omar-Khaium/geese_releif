import 'package:flutter/material.dart';

class SearchWidget extends SearchDelegate<String> {

  SearchWidget();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    return ListView.builder(
      physics: ScrollPhysics(),
      itemBuilder: (context, index) => ListTile(),
      itemCount: 2,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: EdgeInsets.all(16),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile();
            },
            itemCount: 2,
          );
  }
}
