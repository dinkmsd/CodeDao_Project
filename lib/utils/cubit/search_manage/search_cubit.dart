import 'package:bloc/bloc.dart';
import 'package:helper/data/modules.dart';
import 'package:helper/utils/api_helper.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  Future<void> searchWord(String word) async {
    String inputText = word.trim();

    try {
      emit(SearchLoading());

      NewWordInfo dummy = await ApiHelper.getWordModels(inputText);
      emit(SearchWordSuccessed(wordInfo: dummy));
    } catch (e) {
      emit(SearchFailed());
    }
  }

  void searchClause(String clause) async {
    try {
      emit(SearchLoading());
      var meaning = await ApiHelper.getMeaningFromGoogle(clause);
      emit(SearchClauseSuccessed(meaning: meaning));
    } catch (e) {
      emit(SearchFailed());
    }
  }
}
