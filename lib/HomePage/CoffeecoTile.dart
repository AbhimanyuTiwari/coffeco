import 'package:coffeco/Services/DataServices.dart';
import 'package:flutter/material.dart';
class CoffeecoTile extends StatelessWidget {
  final Coffeeco coffeeco;
  CoffeecoTile({this.coffeeco});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:12),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          title: Text(coffeeco.name),
          subtitle: Text("Takes ${coffeeco.sugar} sugar(s)"),
          leading: CircleAvatar(
            backgroundColor: Colors.brown[coffeeco.strength],
            backgroundImage: AssetImage("assets/coffee_icon.png"),
          ),
        ),
      ),
    );
  }
}
