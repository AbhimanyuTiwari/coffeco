import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeco/Services/DataServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'CoffeecoTile.dart';

class CoffeecoList extends StatefulWidget {
  @override
  _CoffeecoListState createState() => _CoffeecoListState();
}

class _CoffeecoListState extends State<CoffeecoList> {
  @override
  Widget build(BuildContext context) {
    final coffeeco = Provider.of<List<Coffeeco>>(context)??[];
    return ListView.builder(
      itemCount: coffeeco.length,
      itemBuilder: (context,index){
        return CoffeecoTile(coffeeco:coffeeco[index]);
      },
    );
  }
}
