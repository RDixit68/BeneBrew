import 'package:benebrew/models/user.dart';
import 'package:benebrew/services/database.dart';
import 'package:benebrew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:benebrew/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

 final _formkey=GlobalKey<FormState>();
 final List<String> sugars=['0','1','2','3','4'];
 //Form Values
String _currentName;
String _currentSugars;
int _currentStrength;
  @override
  Widget build(BuildContext context) {

    final user=Provider.of<TheUser>(context);

      return StreamBuilder<UserData>(
        stream: DatabaseService(uid:user.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            UserData userdata= snapshot.data;

            return Form(
              key: _formkey,
              child:SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Update Your Brew Settings',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      initialValue: userdata.name,
                      decoration: textInputDecoration,
                      validator: (val)=>val.isEmpty? 'Please Enter a Name':null,
                      onChanged: (val)=>setState(()=>_currentName=val),
                    ),
                    SizedBox(height: 20.0),

                    //Dropdown
                    DropdownButtonFormField(
                      decoration: textInputDecoration,
                      value: _currentSugars ?? userdata.sugars,
                      onChanged: (val) {
                        setState(() => _currentSugars = val);
                      },
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                          child: Text("$sugar sugars"),
                          value: sugar,
                        );
                      }).toList(),

                    ),


                    //Slider
                    Slider(
                      value:(_currentStrength ?? userdata.strength).toDouble(),
                      activeColor: Colors.brown[_currentStrength?? userdata.strength],
                      inactiveColor: Colors.brown[_currentStrength ?? userdata.strength],
                      min: 100,
                      max: 900,
                      divisions: 8,
                      onChanged: (val)=>setState(()=>_currentStrength=val.round()),
                    ),



                    RaisedButton(
                      color:Colors.pink[400],
                      child: Text(
                        'Update',
                        style:TextStyle(color:Colors.white),
                      ),
                      onPressed: () async{
                          if(_formkey.currentState.validate()){
                            await DatabaseService(uid: user.uid).updateUserData(
                              _currentSugars ?? userdata.sugars,
                              _currentName ??userdata.name,
                              _currentStrength ?? userdata.strength
                            );
                            Navigator.pop(context);
                          }
                      },
                    )

                  ],
                ),
              ),
            );
          }
          else{
              return Loading();
          }

        }
      );

  }
}
