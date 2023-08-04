import 'package:helper/data/modules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helper/utils/cubit/word_update/word_update_cubit.dart';

class WordDetailPage extends StatefulWidget {
  final NewWordInfo newWordInfo;
  const WordDetailPage({super.key, required this.newWordInfo});

  @override
  State<WordDetailPage> createState() => _WordDetailPageState();
}

class _WordDetailPageState extends State<WordDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Word')),
      body: BlocListener<WordUpdateCubit, WordUpdateState>(
        listener: (context, state) {
          if (state is WordUpdateFailed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Failed network')));
          }
        },
        child: BlocBuilder<WordUpdateCubit, WordUpdateState>(
          builder: (context, state) {
            var newWordInfo = widget.newWordInfo;
            if (state is WordUpdateSuccessed) {
              newWordInfo = state.newWordInfo;
            }

            if (state is WordUpdating) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                newWordInfo.word,
                                style: const TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    context
                                        .read<WordUpdateCubit>()
                                        .onDataUpdated(newWordInfo);
                                  },
                                  icon: newWordInfo.favourite == true
                                      ? const Icon(
                                          Icons.favorite,
                                          size: 36,
                                        )
                                      : const Icon(
                                          Icons.favorite_border,
                                          size: 36,
                                        )),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5,
                                    spreadRadius: 5,
                                    offset: Offset(5, 5))
                              ],
                              gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [Colors.green, Colors.red])),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      'Type: ${newWordInfo.type}',
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    newWordInfo.meaning,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Describe: ${newWordInfo.describe}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ]),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        OutlinedButton(
                            onPressed: () async {
                              context
                                  .read<WordUpdateCubit>()
                                  .onDataDeleted(newWordInfo.word);
                              Navigator.pop(context);
                            },
                            style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                    color: Colors.red, width: 2)),
                            child: const Text(
                              'Delete Word',
                              style: TextStyle(color: Colors.red),
                            )),
                      ]),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
