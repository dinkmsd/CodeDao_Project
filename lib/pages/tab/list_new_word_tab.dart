import 'package:helper/components/customs/custom_nav_bar.dart';
import 'package:helper/components/customs/dialog_custom.dart';
import 'package:helper/components/new_word_item_widget.dart';
import 'package:helper/data/modules.dart';
import 'package:helper/pages/failed_network_page.dart';
import 'package:helper/pages/request_login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../utils/cubit/get_data/get_data_cubit.dart';

class ListNewWordTab extends StatefulWidget {
  const ListNewWordTab({super.key});

  @override
  State<ListNewWordTab> createState() => _ListNewWordTabState();
}

class _ListNewWordTabState extends State<ListNewWordTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetDataCubit, GetDataState>(builder: (context, state) {
      if (state is LoadDataSuccessed) {
        return Column(children: [
          Thebrioflashynavbar(
            selectedIndex: _selectedIndex,
            showElevation: true,
            onItemSelected: (index) => setState(() {
              _selectedIndex = index;
            }),
            items: [
              ThebrioflashynavbarItem(
                icon: const Icon(Icons.all_inbox),
                title: const Text('All'),
              ),
              ThebrioflashynavbarItem(
                icon: const Icon(Icons.favorite),
                title: const Text('Favourite'),
              )
            ],
          ),
          _selectedIndex == 0
              ? Builder(
                  builder: (context) {
                    return BlocListener<GetDataCubit, GetDataState>(
                      listenWhen: (previous, current) =>
                          current is LoadDataSuccessed,
                      listener: (context, state) {
                        _refreshController.refreshCompleted();
                        ScaffoldMessenger.of(context).showSnackBar(
                            DialogCustom.snackBar(
                                context, 'Your refreshed completed'));
                      },
                      child: Expanded(
                        child: BlocBuilder<GetDataCubit, GetDataState>(
                          builder: (context, state) {
                            if (state is LoadDataSuccessed) {
                              var dataFromServer = state.listWords;
                              return SmartRefresher(
                                  controller: _refreshController,
                                  enablePullDown: true,
                                  header: const WaterDropMaterialHeader(),
                                  onRefresh: () {
                                    context
                                        .read<GetDataCubit>()
                                        .onDataFetched();
                                  },
                                  child: ListView.separated(
                                    itemCount: dataFromServer.length,
                                    itemBuilder: (context, index) {
                                      return NewWordItemWidget(
                                          word: dataFromServer[index]);
                                    },
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(
                                        height: 20,
                                      );
                                    },
                                  ));
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ),
                    );
                  },
                )
              : Expanded(
                  child: BlocBuilder<GetDataCubit, GetDataState>(
                    builder: (context, state) {
                      if (state is LoadDataSuccessed) {
                        var dataFromServer = state.listWords;
                        List<NewWordInfo> dummy = [];
                        for (var element in dataFromServer) {
                          if (element.favourite == true) dummy.add(element);
                        }
                        return ListView.separated(
                          itemCount: dummy.length,
                          itemBuilder: (context, index) {
                            return NewWordItemWidget(word: dummy[index]);
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                )
        ]);
      } else if (state is LoadingData) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is UnauthGetDateState) {
        return const RequestLoginPage();
      } else {
        return const FailedNetworkPage();
      }
    });

    // return BlocBuilder<SessionCubit, SessionState>(
    //   builder: (context, state) {
    //     if (state is Authenticated) {
    //       return BlocProvider(
    //         create: (context) => ListWordsCubit(username: state.user.username),
    //         child: Column(children: [
    //           Thebrioflashynavbar(
    //             selectedIndex: _selectedIndex,
    //             showElevation: true,
    //             onItemSelected: (index) => setState(() {
    //               _selectedIndex = index;
    //             }),
    //             items: [
    //               ThebrioflashynavbarItem(
    //                 icon: const Icon(Icons.all_inbox),
    //                 title: const Text('All'),
    //               ),
    //               ThebrioflashynavbarItem(
    //                 icon: const Icon(Icons.favorite),
    //                 title: const Text('Favourite'),
    //               )
    //             ],
    //           ),
    //           _selectedIndex == 0
    //               ? Builder(
    //                   builder: (context) {
    //                     return BlocListener<ListWordsCubit, ListWordsState>(
    //                       listenWhen: (previous, current) =>
    //                           current is ListWordsLoadedSuccess,
    //                       listener: (context, state) {
    //                         _refreshController.refreshCompleted();
    //                         ScaffoldMessenger.of(context).showSnackBar(
    //                             DialogCustom.snackBar(
    //                                 context, 'Your refreshed completed'));
    //                       },
    //                       child: Expanded(
    //                         child: BlocBuilder<ListWordsCubit, ListWordsState>(
    //                           builder: (context, state) {
    //                             if (state is ListWordsLoadedSuccess) {
    //                               var dataFromServer = state.dataList;
    //                               return SmartRefresher(
    //                                   controller: _refreshController,
    //                                   enablePullDown: true,
    //                                   header: const WaterDropMaterialHeader(),
    //                                   onRefresh: () {
    //                                     context
    //                                         .read<ListWordsCubit>()
    //                                         .onDataFetched();
    //                                   },
    //                                   child: ListView.separated(
    //                                     itemCount: dataFromServer.length,
    //                                     itemBuilder: (context, index) {
    //                                       return NewWordItemWidget(
    //                                           word: dataFromServer[index]);
    //                                     },
    //                                     separatorBuilder: (context, index) {
    //                                       return const SizedBox(
    //                                         height: 20,
    //                                       );
    //                                     },
    //                                   ));
    //                             } else {
    //                               return const Center(
    //                                 child: CircularProgressIndicator(),
    //                               );
    //                             }
    //                           },
    //                         ),
    //                       ),
    //                     );
    //                   },
    //                 )
    //               : Expanded(
    //                   child: BlocBuilder<ListWordsCubit, ListWordsState>(
    //                     builder: (context, state) {
    //                       if (state is ListWordsLoadedSuccess) {
    //                         var dataFromServer = state.dataList;
    //                         List<NewWordInfo> dummy = [];
    //                         for (var element in dataFromServer) {
    //                           if (element.favourite == true) dummy.add(element);
    //                         }
    //                         return ListView.separated(
    //                           itemCount: dummy.length,
    //                           itemBuilder: (context, index) {
    //                             return NewWordItemWidget(word: dummy[index]);
    //                           },
    //                           separatorBuilder: (context, index) {
    //                             return const SizedBox(
    //                               height: 20,
    //                             );
    //                           },
    //                         );
    //                       } else {
    //                         return const Center(
    //                           child: CircularProgressIndicator(),
    //                         );
    //                       }
    //                     },
    //                   ),
    //                 )
    //         ]),
    //       );
    //     } else {
    //       return const RequestLoginPage();
    //     }
    //   },
    // );
  }
}
