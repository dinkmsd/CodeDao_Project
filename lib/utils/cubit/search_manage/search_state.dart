part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchWordSuccessed extends SearchState {
  final NewWordInfo wordInfo;
  SearchWordSuccessed({required this.wordInfo});
}

class SearchClauseSuccessed extends SearchState {
  final String meaning;
  SearchClauseSuccessed({required this.meaning});
}

class SearchFailed extends SearchState {}
