import 'package:helper/components/new_item_widget.dart';
import 'package:helper/data/modules.dart';
import 'package:helper/utils/api_helper.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      child: FutureBuilder(
          future: ApiHelper.getListNews(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              var dataListFromServer = snapshot.data as List<NewInfo>;
              return ListView.separated(
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
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
