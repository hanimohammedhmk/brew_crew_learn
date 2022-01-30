import 'package:brew_crew/shared/constant.dart';
import 'package:flutter/material.dart';

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
  String _currentSugar = '0';
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
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
            decoration: textInputDecoration.copyWith(hintText: 'Name'),
            validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
            onChanged: (val) => setState(() => _currentName = val),
          ),
          const SizedBox(
            height: 20.0,
          ),
          //drop down
          DropdownButtonFormField(
            decoration: textInputDecoration,
            hint: const Text('sugars'),
            items: sugar.map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text('$e sugars'),
              );
            }).toList(),
            onChanged: (val) => setState(() => _currentSugar = val.toString()),
          ),
          //slider
          ElevatedButton(
            child: const Text(
              'Update',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              print(_currentName);
              print(_currentSugar);
              print(_currentStrength);
            },
          ),
        ],
      ),
    );
  }
}
