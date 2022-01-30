import 'package:brew_crew/models/myuser.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/constant.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  const SettingForm({Key? key}) : super(key: key);

  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> sugar = ['0', '1', '2', '3', '4'];

  //form values
  String? _currentName;
  String? _currentSugar;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const Text(
                    'Update your brew settings',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: userData?.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  //drop down
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    hint: const Text('sugars'),
                    value: _currentSugar ?? userData?.sugar,
                    items: sugar.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text('$e sugars'),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        setState(() => _currentSugar = val.toString()),
                  ),
                  //slider
                  Slider(
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (val) =>
                        setState(() => _currentStrength = val.round()),
                    value: (_currentStrength ?? userData!.strength).toDouble(),
                    activeColor: Colors.brown[_currentStrength ?? 100],
                    inactiveColor: Colors.brown[_currentStrength ?? 100],
                  ),
                  ElevatedButton(
                    child: const Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentSugar ?? userData!.sugar,
                            _currentName ?? userData!.name,
                            _currentStrength ?? userData!.strength);
                      }
                      print(_currentName);
                      print(_currentSugar);
                      print(_currentStrength);
                    },
                  ),
                ],
              ),
            );
          } else {
            return const Loading();
          }
        });
  }
}
