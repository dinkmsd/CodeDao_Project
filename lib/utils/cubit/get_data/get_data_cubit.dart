import 'package:bloc/bloc.dart';
import 'package:helper/data/modules.dart';
import 'package:helper/utils/api_helper.dart';
import 'package:helper/utils/cubit/session/session_cubit.dart';
import 'package:meta/meta.dart';

part 'get_data_state.dart';

class GetDataCubit extends Cubit<GetDataState> {
  final SessionCubit sessionCubit;
  GetDataCubit({required this.sessionCubit}) : super(UnkownGetDataState()) {
    tryGetData();
  }

  void tryGetData() async {
    try {
      if (sessionCubit.state is Authenticated) {
        emit(LoadingData());
        final listWords = await ApiHelper.getListWords(
            (sessionCubit.state as Authenticated).user.username);
        emit(LoadDataSuccessed(listWords: listWords));
      } else {
        emit(UnauthGetDateState());
      }
    } catch (e) {
      //Handle if user saved in local storage is false
      //sessionCubit change state to Unauthenticated

      emit(LoadDataFailed());
    }
  }

  void onDataFetched() async {
    try {
      if (sessionCubit.state is Authenticated) {
        emit(LoadingData());
        final listWords = await ApiHelper.getListWords(
            (sessionCubit.state as Authenticated).user.username);
        emit(LoadDataSuccessed(listWords: listWords));
      } else {
        emit(UnauthGetDateState());
      }
    } catch (exp) {
      emit(LoadDataFailed());
    }
  }

  void onDataAdded(NewWordInfo dataToAdd) async {
    try {
      if (sessionCubit.state is Authenticated) {
        emit(LoadingData());
        await ApiHelper.addListWords(
            (sessionCubit.state as Authenticated).user.username, dataToAdd);
        final listWords = await ApiHelper.getListWords(
            (sessionCubit.state as Authenticated).user.username);
        emit(LoadDataSuccessed(listWords: listWords));
      } else {
        emit(UnauthGetDateState());
      }
    } catch (exp) {
      emit(LoadDataFailed());
    }
  }

  void onDataRefresh() async {
    try {
      if (sessionCubit.state is Authenticated) {
        emit(LoadingData());
        final listWords = await ApiHelper.getListWords(
            (sessionCubit.state as Authenticated).user.username);
        emit(LoadDataSuccessed(listWords: listWords));
      } else {
        emit(UnauthGetDateState());
      }
    } catch (exp) {
      emit(LoadDataFailed());
    }
  }

  void logoutHandle() {
    sessionCubit.signOut();
    emit(UnauthGetDateState());
  }
}
