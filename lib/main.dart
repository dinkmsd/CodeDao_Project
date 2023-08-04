import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helper/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:helper/utils/cubit/session/session_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SessionCubit(),
      child: const AppNavigator(),
    );
  }

  //   MaterialApp(
  //     title: 'English App',
  //     theme: ThemeData(
  //         primaryColor: Colors.blueGrey[900],
  //         appBarTheme: AppBarTheme(backgroundColor: Colors.blueGrey[900])),
  //     home: BlocProvider(
  //       create: (context) => SessionCubit(),
  //       child: const AppNavigator(),
  //     ),
  //     onGenerateRoute: (settings) {
  //       switch (settings.name) {
  //         case NamedRoute.loginPage:
  //           {
  //             return MaterialPageRoute(builder: (context) => const LoginPage());
  //           }
  //         case NamedRoute.registerPage:
  //           {
  //             return MaterialPageRoute(
  //                 builder: (context) => const RegisterPage());
  //           }
  //         case NamedRoute.dashboardPage:
  //           {
  //             return MaterialPageRoute(
  //                 builder: (context) => const DashboardPage());
  //           }
  //         case NamedRoute.addManualPage:
  //           {
  //             return MaterialPageRoute(
  //                 builder: (context) => const AddManualPage());
  //           }
  //         case NamedRoute.readPage:
  //           {
  //             var dataFromHomePage = settings.arguments as NewInfo;
  //             return MaterialPageRoute(
  //                 builder: (context) => ReadPage(
  //                       newInfo: dataFromHomePage,
  //                     ));
  //           }
  //         case NamedRoute.wordDetailPage:
  //           {
  //             var dataFromListView = settings.arguments as NewWordInfo;
  //             return MaterialPageRoute(
  //                 builder: (context) =>
  //                     WordDetailPage(newWordInfo: dataFromListView));
  //           }
  //       }
  //       return null;
  //     },
  //   );
  // }
}
