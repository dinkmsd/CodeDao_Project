import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helper/data/modules.dart';
import 'package:helper/utils/bloc/register/register_bloc.dart';
import 'package:helper/utils/cubit/auth/auth_cubit.dart';
import 'package:helper/utils/style_custom.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterFailed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.exp.toString())));
          } else if (state is RegisterSuccessed) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Register successed, Pls Login'),
              duration: Duration(milliseconds: 500),
            ));
          }
        },
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            if (state is RegisterFormSubmitting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Full Name',
                      hintStyle: TextStyle(fontSize: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      final nameRegExp = RegExp(
                          r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
                      if (value == null || value == '') {
                        return 'Can\'t empty this field';
                      }
                      if (!nameRegExp.hasMatch(value)) {
                        return 'Enter valid name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      hintStyle: const TextStyle(fontSize: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: const TextStyle(fontSize: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: (value) {
                      final emailRegExp =
                          RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                      if (value == null || value == '') {
                        return 'Can\'t empty this field';
                      }
                      if (!emailRegExp.hasMatch(value)) {
                        return 'Enter valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: const TextStyle(fontSize: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: ((value) {
                      // final passwordRegExp = RegExp(
                      //     r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&+=])(?!.*\s).{9,17}$');
                      if (value == null || value == '') {
                        return 'Can\'t empty this field';
                      }
                      // if (!passwordRegExp.hasMatch(value)) {
                      //   return 'Enter valid password';
                      // }
                      return null;
                    }),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      hintStyle: const TextStyle(fontSize: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: (value) {
                      // final passwordRegExp = RegExp(
                      //     r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&+=])(?!.*\s).{9,17}$');
                      if (value == null || value == '') {
                        return 'Can\'t empty this field';
                      }
                      if (value != passwordController.text) {
                        return 'Pls correct your password';
                      }
                      // if (!passwordRegExp.hasMatch(value)) {
                      //   return 'Enter valid password';
                      // }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final registerInfo = RegisterInfo(
                              fullName: nameController.text,
                              username: usernameController.text,
                              email: emailController.text,
                              password: passwordController.text);

                          context.read<RegisterBloc>().add(
                              RegisterFormSubmitted(
                                  registerInfo: registerInfo));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey[900]),
                      child: Text(
                        'Sign Up'.toUpperCase(),
                      ),
                    ),
                  ),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return TextButton(
                          onPressed: () {
                            context.read<AuthCubit>().showLogin();
                          },
                          child: Text('Already have account? Log in',
                              style: StyleCustom.blueUnderline()));
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> submitSignUp() async {
    final fullname = nameController.text;
    final username = usernameController.text;
    final email = emailController.text;
    final password = passwordController.text;

    final body = {
      'fullname': fullname,
      'username': username,
      'email': email,
      'password': password,
    };
    final uriServer =
        Uri.parse('https://codedao-server.onrender.com/user/register');
    final response = await http.post(
      uriServer,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      // Navigator.pushNamedAndRemoveUntil(
      //     context, NamedRoute.loginPage, (route) => false);
    } else {
      print(response.statusCode);
    }
  }
}
