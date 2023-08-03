import 'package:helper/components/customs/snack_bar_custom.dart';
import 'package:helper/data/modules.dart';
import 'package:helper/utils/api_helper.dart';
import 'package:flutter/material.dart';

class DialogCustom {
  static AlertDialog showDialog(BuildContext context, NewWordInfo word) {
    return AlertDialog(
      title: Text(word.word),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text('Meaning: ${word.meaning}'),
            const SizedBox(
              height: 10,
            ),
            Text('Type: ${word.type}'),
            const SizedBox(
              height: 10,
            ),
            Text('Describe: ${word.describe}')
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            try {
              await ApiHelper.addListWords('dinkmsd', word);
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBarCustom.snackBar('Successed'));
            } catch (e) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBarCustom.snackBar('Failed'));
            }
            Navigator.pop(context);
          },
          child: const Text('Add New word'),
        ),
      ],
    );
  }

  static snackBar(BuildContext context, String message) {
    return SnackBar(
      content: Text(message),
    );
  }
}
