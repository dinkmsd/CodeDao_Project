import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helper/data/modules.dart';
import 'package:flutter/material.dart';
import 'package:helper/pages/word_detail.dart';
import 'package:helper/utils/cubit/get_data/get_data_cubit.dart';
import 'package:helper/utils/cubit/session/session_cubit.dart';
import 'package:helper/utils/cubit/word_update/word_update_cubit.dart';

class NewWordItemWidget extends StatefulWidget {
  final NewWordInfo word;
  const NewWordItemWidget({super.key, required this.word});

  @override
  State<NewWordItemWidget> createState() => _NewWordItemWidgetState();
}

class _NewWordItemWidgetState extends State<NewWordItemWidget> {
  _NewWordItemWidgetState();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return BlocProvider(
                create: (context) => WordUpdateCubit(
                    sessionCubit: context.read<SessionCubit>(),
                    getDataCubit: context.read<GetDataCubit>()),
                child: WordDetailPage(
                  newWordInfo: widget.word,
                ),
              );
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 1,
                  spreadRadius: 1,
                  offset: Offset(5, 5))
            ],
            border: Border.all(),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  widget.word.word,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  widget.word.meaning,
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.right,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
