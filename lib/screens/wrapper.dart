import 'package:benebrew/models/user.dart';
import 'package:benebrew/screens/Home/home.dart';
import 'package:benebrew/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<TheUser>(context);
    print(user);
    //either return home or authenticate
    if (user==null){
      return Authenticate();
    }
    else{
      return home();
    }
    }
  }

