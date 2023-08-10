import 'package:flutter/material.dart';
import 'package:future_loading_dialog/future_loading_dialog.dart';
import 'package:helper/data/user.dart';
import 'package:helper/utils/api_helper.dart';

class ChangePasswordPage extends StatefulWidget {
  final User userInfo;
  ChangePasswordPage({super.key, required this.userInfo});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController currentPasswordController = TextEditingController();

  TextEditingController newPasswordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Password')),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0),
        child: Column(children: [
          TextField(
            controller: currentPasswordController,
            decoration: const InputDecoration(hintText: 'Current password'),
          ),
          const SizedBox(
            height: 12,
          ),
          TextField(
            controller: newPasswordController,
            decoration: const InputDecoration(hintText: 'New password'),
          ),
          const SizedBox(
            height: 12,
          ),
          TextField(
            controller: confirmPasswordController,
            decoration: const InputDecoration(hintText: 'Confirm password'),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  if (currentPasswordController.text == '' ||
                      newPasswordController.text == '' ||
                      confirmPasswordController.text == '') {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Cant empty any field')));
                    return;
                  }
                  if (newPasswordController.text !=
                      confirmPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Passwords do not match')));
                    return;
                  }
                  try {
                    await showFutureLoadingDialog(
                      context: context,
                      future: () => ApiHelper.changePassword(
                          currentPasswordController.text,
                          newPasswordController.text,
                          widget.userInfo.username),
                    );
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  } catch (exp) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('Error')));
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey[900],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                child: const Text("Save"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
