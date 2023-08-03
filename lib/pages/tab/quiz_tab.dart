import 'package:helper/components/reusable_card.dart';
import 'package:helper/data/mocks/all_constants.dart';
import 'package:helper/pages/failed_network_page.dart';
import 'package:helper/pages/request_login_page.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helper/utils/cubit/get_data/get_data_cubit.dart';

class QuizTab extends StatefulWidget {
  const QuizTab({super.key});

  @override
  State<QuizTab> createState() => _QuizTabState();
}

class _QuizTabState extends State<QuizTab> {
  int _currentIndexNumber = 0;
  int numCard = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetDataCubit, GetDataState>(builder: (context, state) {
      if (state is LoadDataSuccessed) {
        var dataFromServer = state.listWords;
        numCard = dataFromServer.isNotEmpty ? dataFromServer.length : 1;
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  "Question ${_currentIndexNumber + 1} of ${numCard} Completed",
                  style: otherTextStyle),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation(Colors.blueGrey[900]),
                  minHeight: 5,
                  value: ((_currentIndexNumber + 1) / (numCard)),
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                  width: 300,
                  height: 300,
                  child: FlipCard(
                      direction: FlipDirection.VERTICAL,
                      front: ReusableCard(
                          text: dataFromServer[_currentIndexNumber].word),
                      back: ReusableCard(
                          text: dataFromServer[_currentIndexNumber].meaning))),
              const Text("Tab to see Answer", style: otherTextStyle),
              const SizedBox(height: 20),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ElevatedButton.icon(
                        onPressed: () {
                          showPreviousCard();
                        },
                        icon: const Icon(Icons.arrow_back, size: 30),
                        label: const Text(""),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey[900],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.only(
                                right: 20, left: 25, top: 15, bottom: 15))),
                    ElevatedButton.icon(
                        onPressed: () {
                          showNextCard();
                        },
                        icon: const Icon(Icons.arrow_forward, size: 30),
                        label: const Text(""),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey[900],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.only(
                                right: 20, left: 25, top: 15, bottom: 15)))
                  ])
            ]);
      } else if (state is UnauthGetDateState) {
        return const RequestLoginPage();
      } else if (state is LoadingData) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return const FailedNetworkPage();
      }
    });

    // return BlocBuilder<SessionCubit, SessionState>(
    //   builder: (context, state) {
    //     if (state is Authenticated) {
    //       return BlocProvider(
    //         create: (context) => ListWordsCubit(username: state.user.username),
    //         child: Scaffold(
    //             backgroundColor: Colors.grey.shade100,
    //             body: Center(child: BlocBuilder<ListWordsCubit, ListWordsState>(
    //               builder: (context, state) {
    //                 if (state is ListWordsLoadedSuccess) {
    //                   var dataFromServer = state.dataList;
    //                   numCard =
    //                       dataFromServer.isNotEmpty ? dataFromServer.length : 1;
    //                   return Column(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: <Widget>[
    //                         Text(
    //                             "Question ${_currentIndexNumber + 1} of ${numCard} Completed",
    //                             style: otherTextStyle),
    //                         const SizedBox(height: 20),
    //                         Padding(
    //                           padding: const EdgeInsets.all(10.0),
    //                           child: LinearProgressIndicator(
    //                             backgroundColor: Colors.white,
    //                             valueColor: AlwaysStoppedAnimation(
    //                                 Colors.blueGrey[900]),
    //                             minHeight: 5,
    //                             value: ((_currentIndexNumber + 1) / (numCard)),
    //                           ),
    //                         ),
    //                         const SizedBox(height: 25),
    //                         SizedBox(
    //                             width: 300,
    //                             height: 300,
    //                             child: FlipCard(
    //                                 direction: FlipDirection.VERTICAL,
    //                                 front: ReusableCard(
    //                                     text:
    //                                         dataFromServer[_currentIndexNumber]
    //                                             .word),
    //                                 back: ReusableCard(
    //                                     text:
    //                                         dataFromServer[_currentIndexNumber]
    //                                             .meaning))),
    //                         const Text("Tab to see Answer",
    //                             style: otherTextStyle),
    //                         const SizedBox(height: 20),
    //                         Row(
    //                             mainAxisAlignment:
    //                                 MainAxisAlignment.spaceAround,
    //                             children: <Widget>[
    //                               ElevatedButton.icon(
    //                                   onPressed: () {
    //                                     showPreviousCard();
    //                                   },
    //                                   icon: const Icon(Icons.arrow_back,
    //                                       size: 30),
    //                                   label: const Text(""),
    //                                   style: ElevatedButton.styleFrom(
    //                                       backgroundColor: Colors.blueGrey[900],
    //                                       shape: RoundedRectangleBorder(
    //                                           borderRadius:
    //                                               BorderRadius.circular(10)),
    //                                       padding: const EdgeInsets.only(
    //                                           right: 20,
    //                                           left: 25,
    //                                           top: 15,
    //                                           bottom: 15))),
    //                               ElevatedButton.icon(
    //                                   onPressed: () {
    //                                     showNextCard();
    //                                   },
    //                                   icon: const Icon(Icons.arrow_forward,
    //                                       size: 30),
    //                                   label: const Text(""),
    //                                   style: ElevatedButton.styleFrom(
    //                                       backgroundColor: Colors.blueGrey[900],
    //                                       shape: RoundedRectangleBorder(
    //                                           borderRadius:
    //                                               BorderRadius.circular(10)),
    //                                       padding: const EdgeInsets.only(
    //                                           right: 20,
    //                                           left: 25,
    //                                           top: 15,
    //                                           bottom: 15)))
    //                             ])
    //                       ]);
    //                 } else {
    //                   return const Center(
    //                     child: CircularProgressIndicator(),
    //                   );
    //                 }
    //               },
    //             ))),
    //       );
    //     } else {
    //       return const RequestLoginPage();
    //     }
    //   },
    // );
  }

  void showNextCard() {
    setState(() {
      _currentIndexNumber =
          (_currentIndexNumber + 1 < numCard) ? _currentIndexNumber + 1 : 0;
    });
  }

  void showPreviousCard() {
    setState(() {
      _currentIndexNumber = (_currentIndexNumber - 1 >= 0)
          ? _currentIndexNumber - 1
          : numCard - 1;
    });
  }
}
