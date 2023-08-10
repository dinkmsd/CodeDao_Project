import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helper/data/modules.dart';
import 'package:flutter/material.dart';
import 'package:helper/utils/api_helper.dart';
import 'package:helper/utils/cubit/get_data/get_data_cubit.dart';
import 'package:helper/utils/cubit/session/session_cubit.dart';
import 'package:word_selectable_text/word_selectable_text.dart';

class ReadPage extends StatefulWidget {
  final NewInfo newInfo;
  const ReadPage({super.key, required this.newInfo});

  @override
  State<ReadPage> createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Text(
                widget.newInfo.title,
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                child: WordSelectableText(
                    selectable: true,
                    highlight: true,
                    text: widget.newInfo.description,
                    onWordTapped: (word, index) async {
                      NewWordInfo dummy = await ApiHelper.getWordModels(word);
                      if (!mounted) return;
                      final getDataProvider = context.read<GetDataCubit>();
                      showDialog(
                          context: context,
                          builder: (context) {
                            return BlocProvider.value(
                              value: getDataProvider,
                              child: BlocBuilder<GetDataCubit, GetDataState>(
                                builder: (context, state) {
                                  return AlertDialog(
                                    title: Text(dummy.word),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: [
                                          Text('Meaning: ${dummy.meaning}'),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text('Type: ${dummy.type}'),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text('Describe: ${dummy.describe}')
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          if (state is UnauthGetDateState) {
                                            Navigator.of(context).pop();

                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'You need login to use this feature'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child:
                                                          const Text('Cancel'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        context
                                                            .read<
                                                                SessionCubit>()
                                                            .isAuthenticating();
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          const Text('Login'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          } else {
                                            context
                                                .read<GetDataCubit>()
                                                .onDataAdded(dummy);
                                            Navigator.of(context).pop();
                                          }
                                        },
                                        child: const Text('Add New word'),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            );
                          });
                    },
                    style: const TextStyle(fontSize: 20)))
          ],
        ),
      ),
    );
  }
}
