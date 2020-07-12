import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeco/HomePage/CoffeecoList.dart';
import 'package:coffeco/Services/DataServices.dart';
import 'package:coffeco/Services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'SettingForm.dart';
class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}


class _homePageState extends State<homePage> {
  AuthServices auth=AuthServices();
  @override
  Widget build(BuildContext context) {
    void settingPanel(){
      showModalBottomSheet(isScrollControlled:true,context: context, builder: (context){
        return Padding(
          padding:MediaQuery.of(context).viewInsets,
          child: Container(
            padding: EdgeInsets.all(12),
            child:SettingForm()
          ),
        );
      });
    }

    return Scaffold(
      backgroundColor: Colors.brown[100],
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text("Coffeeco"),
        backgroundColor: Colors.brown[400],
        actions: <Widget>[
          FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text("Logout"),
            onPressed: () async {
              auth.signOut();
            },
          ),
          FlatButton.icon(
              onPressed: settingPanel,
               icon: Icon(Icons.settings),
              label: Text("Settings"))
        ],
      ),
      body: StreamProvider<List<Coffeeco>>.value(value: DataServices().coffeeco,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/coffee_bg.png"),
                  fit:BoxFit.cover
            )
          ),
          child: CoffeecoList(),
        )
      ),
    );
  }
}
