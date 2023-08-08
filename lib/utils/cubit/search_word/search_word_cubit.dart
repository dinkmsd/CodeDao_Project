import 'package:bloc/bloc.dart';
import 'package:helper/data/modules.dart';
import 'package:meta/meta.dart';

import '../../api_helper.dart';

part 'search_word_state.dart';

class SearchWordCubit extends Cubit<SearchWordState> {
  SearchWordCubit(String word) : super(SearchWordInitial()) {
    searchWord(word);
  }

  void searchWord(String word) async {
    String inputText = word.trim();

    try {
      emit(SearchWordLoading());

      NewWordInfo dummy = await ApiHelper.getWordModels(inputText);
      emit(SearchWordSuccessed(wordInfo: dummy));
    } catch (e) {
      emit(SearchWordFailed());
    }
  }
}
