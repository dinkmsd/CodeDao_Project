import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helper/pages/dashboard_page.dart';
import 'package:helper/utils/auth/auth_navigator.dart';
import 'package:helper/utils/cubit/auth/auth_cubit.dart';
import 'package:helper/utils/cubit/get_data/get_data_cubit.dart';
import 'package:helper/utils/cubit/session/session_cubit.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.blueGrey[900],
          appBarTheme: AppBarTheme(backgroundColor: Colors.blueGrey[900])),
      home: BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
        return Navigator(
          pages: [
            // Show loading screen
            if (state is Authenticating) ...[
              MaterialPage(
                child: BlocProvider(
                  create: (context) =>
                      AuthCubit(sessionCubit: context.read<SessionCubit>()),
                  child: const AuthNavigator(),
                ),
              )
            ] else ...[
              MaterialPage(
                  child: BlocProvider(
                create: (context) =>
                    GetDataCubit(sessionCubit: context.read<SessionCubit>()),
                child: const DashboardPage(),
              ))
            ]
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      }),
    );
  }
}
