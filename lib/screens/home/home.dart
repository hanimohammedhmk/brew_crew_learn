import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      initialData: const [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: const Text('Brew Crew'),
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: const Icon(
                Icons.person,
                color: Colors.yellow,
              ),
              label: const Text(
                'logout',
                style: TextStyle(color: Colors.yellow),
              ),
            )
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
