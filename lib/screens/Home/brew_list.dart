import 'package:flutter/material.dart';
import 'package:benebrew/models/brew.dart';
import 'package:provider/provider.dart';
import 'package:benebrew/screens/Home/brew_tile.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {

    final brews=Provider.of<List<Brew>>(context) ?? [] ;
    //print(brews.documents);
   brews.forEach((brew) {
     print(brew.name);
     print(brew.sugars);
     print(brew.strength);
   });
    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context,index){
        return BrewTile(brew: brews[index]);
      },
    );
  }
}
