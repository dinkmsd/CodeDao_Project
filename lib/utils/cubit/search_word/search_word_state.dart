part of 'search_word_cubit.dart';

@immutable
sealed class SearchWordState {}

final class SearchWordInitial extends SearchWordState {}

class SearchWordLoading extends SearchWordState {}

class SearchWordSuccessed extends SearchWordState {
  final NewWordInfo wordInfo;
  SearchWordSuccessed({required this.wordInfo});
}

class SearchWordFailed extends SearchWordState {}
