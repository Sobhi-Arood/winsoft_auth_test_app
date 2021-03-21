import 'package:flutter/material.dart';
import 'package:winsoft_auth_test_app/models/user.dart';

class HomePage extends StatelessWidget {
  final User user;
  HomePage(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('Welcome ${user.firstName} ${user.lastName}'),),
    );
  }
}