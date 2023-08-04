import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helper/utils/cubit/session/session_cubit.dart';

class RequestLoginPage extends StatefulWidget {
  const RequestLoginPage({super.key});

  @override
  State<RequestLoginPage> createState() => _RequestLoginPageState();
}

class _RequestLoginPageState extends State<RequestLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text('You need login to use this feature'),
          BlocBuilder<SessionCubit, SessionState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  context.read<SessionCubit>().isAuthenticating();
                  // Navigator.pushNamed(context, NamedRoute.authNavigatorPage);
                },
                child: const Text('Login'),
              );
            },
          ),
        ],
      ),
    );
  }
}
