import 'package:coffeco/Services/DataServices.dart';
import 'package:coffeco/Services/auth.dart';
import 'package:coffeco/constants/sign_in_buttons.dart';
import 'package:coffeco/constants/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final List<String> sugar = ['0', '1', '2', '3', '4'];
  String _currentName;
  String _currentSugar;
  int _currentStrength;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DataServices(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData=snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Update Your Details",style: TextStyle(
                    fontSize: 20,
                    color: Colors.brown,
                    fontWeight: FontWeight.bold,
                  ),),
                  SizedBox(
                    height:20
                  ),
                  TextFormField(
                    initialValue: _currentName??userData.name,
                    decoration: inputDecoration,
                    onChanged: (val) {
                      setState(() {
                        _currentName = val;
                      });
                    },
                    validator: (value) => value.isEmpty ? "Enter name" : null,

                  ),
                  SizedBox(height: 20.0),
                  DropdownButtonFormField(
                    value: _currentSugar??userData.sugar,
                    items: sugar.map((sugarItems) {
                      return DropdownMenuItem(
                        value: sugarItems,
                        child: Text('$sugarItems sugars'),
                      );
                    }
                    ).toList(),
                    onChanged: (val) {
                      setState(() {
                        _currentSugar = val;
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  Text("Strength of Coffee"),
                  Slider(
                    value: (_currentStrength??userData.strength).toDouble() ?? 100,
                    min: 100,
                    max: 900,
                    divisions: 8,
                    activeColor: Colors.brown[_currentStrength??userData.strength],
                    inactiveColor: Colors.brown[_currentStrength??userData.strength],
                    onChanged: (value) {
                      setState(() {
                        _currentStrength = value.round();
                      });
                    },
                  ),
                  SizedBox(height: 20,),
                  signInButton(
                    text: "Update",
                    color: Colors.pink,
                    textcolor: Colors.white,
                    onPressed: () async{
                      if(_formKey.currentState.validate())
                        {
                            await DataServices(uid:user.uid).updateUserData(
                                _currentName??userData.name,
                                _currentSugar??userData.sugar,
                                _currentStrength??userData.strength);
                            Navigator.pop(context);
                        }

                    },
                  )


                ],
              ),
            );
          }
          else
            return Loading();
        }
    );
  }
}
