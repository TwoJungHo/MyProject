import 'package:flutter/material.dart';
import 'package:newmyflutter/loginprovider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                labelText: 'ID',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final id = _idController.text;
                final password = _passwordController.text;
                final loginProvider = Provider.of<LoginProvider>(context, listen: false);

                loginProvider.login(id, password);
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
