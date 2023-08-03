import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helper/auth/abc/cubit/session_cubit.dart';
import 'package:helper/auth/cubit/auth_cubit.dart';
import 'package:helper/components/forgot_password.dart';
import 'package:helper/utils/style_custom.dart';
import 'package:flutter/material.dart';

import '../../auth/form_submission_status.dart';
import '../../auth/login/bloc/login_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isChecked = false;
  bool _obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, (formStatus).exception.toString());
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return TextFormField(
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
                  onChanged: (value) {
                    context
                        .read<LoginBloc>()
                        .add(LoginUsernameChanged(username: value));
                  },
                );
              },
            ),
            const SizedBox(
              height: 12.0,
            ),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return TextFormField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    hintText: 'Password',
                    hintStyle: const TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  onChanged: (value) {
                    context.read<LoginBloc>().add(
                          LoginPasswordChanged(password: value),
                        );
                  },
                );
              },
            ),
            const SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                        value: _isChecked,
                        onChanged: (value) {
                          setState(() {
                            _isChecked = !_isChecked;
                          });
                        }),
                    const Text('Remember me')
                  ],
                ),
                TextButton(
                  child: Text(
                    'Forgot Password?',
                    style: StyleCustom.blueUnderline(),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotPassword()),
                    );
                  },
                )
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return state.formStatus is FormSubmitting
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          // onPressed: submitLogin,
                          onPressed: () {
                            context.read<LoginBloc>().add(LoginSubmitted());
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey[900]),
                          child: Text(
                            'Login'.toUpperCase(),
                          ),
                        );
                },
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<AuthCubit>().showSignUp();
              },
              child: Text(
                'New here? Register',
                style: StyleCustom.blueUnderline(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                context.read<SessionCubit>().skipAuthentice();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Skip',
                    style: StyleCustom.blueUnderline(),
                  ),
                  const Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
