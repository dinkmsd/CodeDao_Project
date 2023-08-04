import 'package:bloc/bloc.dart';
import 'package:helper/data/modules.dart';
import 'package:helper/utils/api_helper.dart';
import 'package:helper/utils/cubit/get_data/get_data_cubit.dart';
import 'package:helper/utils/cubit/session/session_cubit.dart';
import 'package:meta/meta.dart';

part 'word_update_state.dart';

class WordUpdateCubit extends Cubit<WordUpdateState> {
  final SessionCubit sessionCubit;
  final GetDataCubit getDataCubit;
  WordUpdateCubit({required this.sessionCubit, required this.getDataCubit})
      : super(WordUpdateInitial());

  void onDataUpdated(NewWordInfo dataToUpdate) async {
    try {
      if (sessionCubit.state is Authenticated) {
        emit(WordUpdating());
        dataToUpdate.favourite = !(dataToUpdate.favourite);

        await ApiHelper.updateListWords(
            (sessionCubit.state as Authenticated).user.username, dataToUpdate);
        getDataCubit.onDataRefresh();
        emit(WordUpdateSuccessed(newWordInfo: dataToUpdate));
      } else {
        emit(WordUpdateFailed());
      }
    } catch (exp) {
      emit(WordUpdateFailed());
    }
  }

  void onDataDeleted(String word) async {
    try {
      if (sessionCubit.state is Authenticated) {
        emit(WordUpdating());
        await ApiHelper.deleteListWords(
            (sessionCubit.state as Authenticated).user.username, word);
        getDataCubit.onDataRefresh();
        getDataCubit.onDataRefresh();
        emit(WordDeleteSuccessed());
      } else {
        emit(WordUpdateFailed());
      }
    } catch (exp) {
      emit(WordUpdateFailed());
    }
  }
}
