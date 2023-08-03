import 'package:bloc/bloc.dart';
import 'package:helper/utils/api_helper.dart';
import 'package:meta/meta.dart';

import '../../data/modules.dart';

part 'list_words_state.dart';

class ListWordsCubit extends Cubit<ListWordsState> {
  final String username;
  ListWordsCubit({required this.username}) : super(ListWordsInitial()) {
    if (username == '') {
      emit(NotLoggedState());
    } else {
      onDataFetched();
    }
  }

  void onDataFetched() async {
    try {
      emit(ListWordsLoading());
      var dataFromServer = await ApiHelper.getListWords(username);
      emit(ListWordsLoadedSuccess(dataList: dataFromServer));
    } catch (exp) {
      emit(NetworkErrorState());
      throw Exception('Failed Network');
    }
  }

  void onDataUpdated(NewWordInfo dataToUpdate) async {
    await ApiHelper.updateListWords(dataToUpdate);

    var dataFromServer = await ApiHelper.getListWords(username);
    emit(ListWordsLoadedSuccess(dataList: dataFromServer));
  }

  void onDataDeleted(String word) async {
    await ApiHelper.deleteListWords(username, word);

    var dataFromServer = await ApiHelper.getListWords(username);
    emit(ListWordsLoadedSuccess(dataList: dataFromServer));
  }

  void onDataAdded(NewWordInfo dataToAdd) async {
    await ApiHelper.addListWords(username, dataToAdd);

    var dataFromServer = await ApiHelper.getListWords(username);
    emit(ListWordsLoadedSuccess(dataList: dataFromServer));
  }

  void onDataRefresh() async {
    var dataFromServer = await ApiHelper.getListWords(username);
    emit(ListWordsLoadedSuccess(dataList: dataFromServer));
  }
}
