import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helper/components/new_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:helper/utils/cubit/get_new/get_new_cubit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 8),
        child: BlocListener<GetNewCubit, GetNewState>(
          listenWhen: (previous, current) => current is LoadedNewSuccess,
          listener: (context, state) {
            // TODO: implement listener
            _refreshController.refreshCompleted();
          },
          child: BlocBuilder<GetNewCubit, GetNewState>(
            builder: (context, state) {
              if (state is LoadedNewSuccess) {
                final dataListFromServer = state.listNews;

                return SmartRefresher(
                    controller: _refreshController,
                    enablePullDown: true,
                    header: const WaterDropMaterialHeader(),
                    onRefresh: () {
                      context.read<GetNewCubit>().attempGetNews();
                    },
                    child: ListView.separated(
                      itemCount: dataListFromServer.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 20,
                        );
                      },
                      itemBuilder: (context, index) {
                        return NewItemWidget(
                          newInfo: dataListFromServer[index],
                        );
                      },
                    ));
              } else if (state is LoadingNew) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SmartRefresher(
                    controller: _refreshController,
                    enablePullDown: true,
                    header: const WaterDropMaterialHeader(),
                    onRefresh: () {
                      context.read<GetNewCubit>().attempGetNews();
                    },
                    child: const Center(
                      child: Text('Loaded Data Failed!!!'),
                    ));
              }
            },
          ),
        ));
  }
}
