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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('You need login to use this feature'),
          const SizedBox(
            height: 12,
          ),
          BlocBuilder<SessionCubit, SessionState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  context.read<SessionCubit>().isAuthenticating();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey[900],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                child: const Text('Login'),
              );
            },
          ),
        ],
      ),
    );
  }
}
