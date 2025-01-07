import 'package:flutter/material.dart';
import 'login_page.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User  Page'),
      ),
      body: Center(
        child: Text('Welcome User!'),
      ),
    );
  }
}