import 'package:bloc/bloc.dart';
import 'package:helper/data/modules.dart';
import 'package:helper/utils/api_helper.dart';
import 'package:meta/meta.dart';

part 'get_new_state.dart';

class GetNewCubit extends Cubit<GetNewState> {
  GetNewCubit() : super(GetNewInitial()) {
    attempGetNews();
  }

  void attempGetNews() async {
    try {
      emit(LoadingNew());
      final listNews = await ApiHelper.getListNews();
      emit(LoadedNewSuccess(listNews: listNews));
    } catch (exp) {
      emit(LoadedNewFailed());
      rethrow;
    }
  }
}
