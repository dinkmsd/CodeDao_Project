import 'package:helper/components/customs/dialog_custom.dart';
import 'package:helper/components/customs/snack_bar_custom.dart';
import 'package:helper/data/modules.dart';
import 'package:helper/utils/api_helper.dart';
import 'package:flutter/material.dart';
import 'package:helper/data/mocks/pattern.dart';
import 'package:word_selectable_text/word_selectable_text.dart';

class ReadPage extends StatefulWidget {
  final NewInfo newInfo;
  const ReadPage({super.key, required this.newInfo});

  @override
  State<ReadPage> createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
  bool sentenceMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Read')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(widget.newInfo.imageAddress),
            const SizedBox(
              height: 10,
            ),
            Text(
              titleDemo.title,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                child: sentenceMode == false
                    ? WordSelectableText(
                        selectable: true,
                        highlight: true,
                        text: widget.newInfo.description,
                        onWordTapped: (word, index) async {
                          // if (word.endsWith('s')) {
                          //   word = word.substring(0, word.length - 1);
                          // }
                          // if (word.endsWith('es')) {
                          //   word = word.substring(0, word.length - 2);
                          // }

                          // int indexOfApostrophe = word.indexOf("'");
                          // if (indexOfApostrophe != -1) {
                          //   word = word.substring(0, indexOfApostrophe + 1);
                          // }
                          // print(word);

                          try {
                            NewWordInfo dummy =
                                await ApiHelper.getWordModels(word);
                            // ignore: use_build_context_synchronously
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return DialogCustom.showDialog(
                                      context, dummy);
                                });
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBarCustom.snackBar(
                                    'Can\'t find this word'));
                          }
                        },
                        style: const TextStyle(fontSize: 20))
                    : SelectableText(
                        widget.newInfo.description,
                      ))
          ],
        ),
      ),
    );
  }
}
