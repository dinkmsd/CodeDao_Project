import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helper/auth/abc/cubit/session_cubit.dart';
import 'package:helper/data/mocks/pattern.dart';
import 'package:helper/pages/change_info_page.dart';
import 'package:helper/pages/request_login_page.dart';
import 'package:helper/utils/cubit/get_data/get_data_cubit.dart';
import 'package:helper/utils/widgets/pfp_widget.dart';
import 'package:helper/utils/widgets/stats_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoTab extends StatefulWidget {
  const UserInfoTab({super.key});

  @override
  State<UserInfoTab> createState() => _UserInfoTabState();
}

class _UserInfoTabState extends State<UserInfoTab> {
  Future<String> loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? '';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
      if (state is UnknownSessionState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is Unauthenticated) {
        return const RequestLoginPage();
      }
      final user = (state as Authenticated).user;
      return Scaffold(
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(
              height: 17,
            ),
            ProfileWidget(
              imagePath: userInfo.profilePic,
              onClicked: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const ChangeUserInfoPage();
                    },
                  ),
                );
              },
              icon: Icons.edit,
            ),
            const SizedBox(
              height: 9,
            ),
            Column(
              children: [
                Text(
                  user.fullname,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(user.username, style: const TextStyle(color: Colors.grey)),
                const SizedBox(
                  height: 40,
                ),
                const StatsRowWidget(),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  context.read<GetDataCubit>().logoutHandle();
                },
                child: const Text('Logout')),
          ],
        ),
      );
    });
  }
}
