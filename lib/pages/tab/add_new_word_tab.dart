import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helper/components/customs/dialog_custom.dart';
import 'package:helper/components/word_search_card.dart';
import 'package:helper/data/modules.dart';
import 'package:helper/pages/add_manual_page.dart';
import 'package:flutter/material.dart';
import 'package:helper/utils/cubit/get_data/get_data_cubit.dart';
import 'package:helper/utils/cubit/search_manage/search_cubit.dart';
import 'package:helper/utils/cubit/session/session_cubit.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: Builder(builder: (context) {
        return BlocListener<SearchCubit, SearchState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is SearchFailed) {
              ScaffoldMessenger.of(context).showSnackBar(DialogCustom.snackBar(
                  context, 'Error while searching for word.'));
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Search',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    hintText: 'Enter the word you\'re looking for ...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          // Handle

                          focusNode.unfocus();
                          final List listWord = (controller.text).split(' ');
                          if (listWord.length == 1) {
                            context
                                .read<SearchCubit>()
                                .searchWord(controller.text);
                          } else {
                            context
                                .read<SearchCubit>()
                                .searchClause(controller.text);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey[900],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        child: const Text('Search'),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const AddManualPage();
                            },
                          ));
                        },
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(
                                color: Colors.blueGrey[900]!, width: 2)),
                        child: const Text(
                          'Add Manually',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    if (state is SearchLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is SearchWordSuccessed) {
                      return cardBoGoc(state.wordInfo, context);
                    } else if (state is SearchClauseSuccessed) {
                      return tuBoGoc(state.meaning);
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget cardBoGoc(NewWordInfo word, BuildContext context) {
    return BlocBuilder<GetDataCubit, GetDataState>(
      builder: (context, state) {
        final getDataProvider = context.read<GetDataCubit>();
        return WordSearchCard(
            wordModel: word,
            onPress: () {
              // Show confirmation dialog with platform specific ui
              showDialog(
                  context: context,
                  builder: (context) {
                    return BlocProvider.value(
                      value: getDataProvider,
                      child: BlocBuilder<GetDataCubit, GetDataState>(
                        builder: (context, state) {
                          return AlertDialog(
                            title: const Text("Add to vocabulary?"),
                            content: Text(
                                "The word ${word.word} will be added to your vocabulary"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel')),
                              TextButton(
                                  onPressed: () {
                                    // Handle add word

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
                                                child: const Text('Cancel'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  context
                                                      .read<SessionCubit>()
                                                      .isAuthenticating();
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Login'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      context
                                          .read<GetDataCubit>()
                                          .onDataAdded(word);
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: const Text('Add')),
                            ],
                          );
                        },
                      ),
                    );
                  });
            });
      },
    );
  }

  Widget tuBoGoc(String meaning) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        meaning,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
