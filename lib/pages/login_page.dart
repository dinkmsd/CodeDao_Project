import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helper/auth/cubit/auth_cubit.dart';
import 'package:helper/auth/login/bloc/login_bloc.dart';
import 'package:helper/components/forms/login_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: BlocProvider(
        create: (context) => LoginBloc(authCubit: context.read<AuthCubit>()),
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
                    height: MediaQuery.of(context).size.height / 5,
                    child: const Text(
                      'Logo',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const LoginForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
