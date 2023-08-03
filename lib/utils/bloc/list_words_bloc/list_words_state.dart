part of 'list_words_bloc.dart';

@immutable
abstract class HandleDataBlocState {
  final List<NewWordInfo> dataList;
  const HandleDataBlocState(this.dataList);
}

class ListWordsInitial extends HandleDataBlocState {
  const ListWordsInitial(super.dataList);
}

class ListWordsLoading extends HandleDataBlocState {
  const ListWordsLoading(super.dataList);
}

class ListWordsLoadedSuccess extends HandleDataBlocState {
  const ListWordsLoadedSuccess(super.dataList);
}
