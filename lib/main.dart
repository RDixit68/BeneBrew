import 'package:benebrew/models/user.dart';
import 'package:benebrew/screens/wrapper.dart';
import 'package:benebrew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:benebrew/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<TheUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: wrapper(),
      ),
    );
  }
}
