import 'package:bloc/bloc.dart';
import 'package:helper/data/modules.dart';
import 'package:helper/utils/api_helper.dart';
import 'package:meta/meta.dart';

part 'list_words_event.dart';
part 'list_words_state.dart';

class HandleDataBloc extends Bloc<ListWordsEvent, HandleDataBlocState> {
  final String username;

  HandleDataBloc({required this.username})
      : super(const ListWordsInitial(<NewWordInfo>[])) {
    on<ListWordsFetched>(_onDataFetched);
    on<ListWordsUpdated>(_onDataUpdated);
    on<ListWordsDeleted>(_onDataDeleted);
    on<ListWordsAdded>(_onDataAdded);
    on<ListWordsRefresh>(_onDataRefresh);
  }

  _onDataFetched(
      ListWordsFetched event, Emitter<HandleDataBlocState> emit) async {
    emit(ListWordsLoading(state.dataList));
    var dataFromServer = await ApiHelper.getListWords('dinkmsd');
    emit(ListWordsLoadedSuccess(dataFromServer));
  }

  _onDataUpdated(
      ListWordsUpdated event, Emitter<HandleDataBlocState> emit) async {
    await ApiHelper.updateListWords(event.dataToUpdate);

    var dataFromServer = await ApiHelper.getListWords('dinkmsd');
    emit(ListWordsLoadedSuccess(dataFromServer));
  }

  _onDataDeleted(
      ListWordsDeleted event, Emitter<HandleDataBlocState> emit) async {
    await ApiHelper.deleteListWords('dinkmsd', event.dataToDeleted.word);

    var dataFromServer = await ApiHelper.getListWords('dinkmsd');
    emit(ListWordsLoadedSuccess(dataFromServer));
  }

  _onDataAdded(ListWordsAdded event, Emitter<HandleDataBlocState> emit) async {
    await ApiHelper.addListWords('dinkmsd', event.dataToAdded);

    var dataFromServer = await ApiHelper.getListWords('dinkmsd');
    emit(ListWordsLoadedSuccess(dataFromServer));
  }

  _onDataRefresh(
      ListWordsRefresh event, Emitter<HandleDataBlocState> emit) async {
    var dataFromServer = await ApiHelper.getListWords('dinkmsd');
    emit(ListWordsLoadedSuccess(dataFromServer));
  }
}
