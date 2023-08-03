import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  ChangePassword createState() => ChangePassword();
}

class ChangePassword extends State<ChangePasswordScreen> {
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text('Change Password'),
              onPressed: () {
                String newPassword = _newPasswordController.text;
                String confirmPassword = _confirmPasswordController.text;

                if (newPassword == confirmPassword) {
                } else {}
              },
            ),
          ],
        ),
      ),
    );
  }
}
