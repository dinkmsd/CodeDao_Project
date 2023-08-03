import 'package:helper/components/forms/register_form.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 7,
                    child: const Text('Hello')),
                const SizedBox(
                  height: 32,
                ),
                const RegisterForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
