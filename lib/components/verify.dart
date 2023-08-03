import 'dart:async';

import 'package:helper/components/change_password.dart';
import 'package:flutter/material.dart';

class VerifyScreen extends StatefulWidget {
  @override
  _PhoneVerificationScreenState createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<VerifyScreen> {
  int _remainingTime = 60;
  late Timer _timer;
  String _verificationCode = '';

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_remainingTime == 0) {
        timer.cancel();
      } else {
        setState(() {
          _remainingTime--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'VERIFY',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              '$_remainingTime seconds',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Enter Your Code',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _verificationCode = value;
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: Text('Verify'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangePasswordScreen()),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Resend Code'),
              onPressed: () {
                if (_remainingTime == 0) {
                  // Gửi lại mã xác minh
                  setState(() {
                    _remainingTime = 60;
                    _verificationCode = '';
                  });
                  startTimer();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
