part of 'list_words_cubit.dart';

@immutable
abstract class ListWordsState {}

class ListWordsInitial extends ListWordsState {}

class ListWordsLoading extends ListWordsState {}

class NotLoggedState extends ListWordsState {}

class NetworkErrorState extends ListWordsState {}

class ListWordsLoadedSuccess extends ListWordsState {
  final List<NewWordInfo> dataList;
  ListWordsLoadedSuccess({required this.dataList});
}
