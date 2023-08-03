part of 'list_words_bloc.dart';

@immutable
abstract class ListWordsEvent {}

class ListWordsFetched extends ListWordsEvent {}

class ListWordsUpdated extends ListWordsEvent {
  final NewWordInfo dataToUpdate;

  ListWordsUpdated({required this.dataToUpdate});
}

class ListWordsDeleted extends ListWordsEvent {
  final NewWordInfo dataToDeleted;

  ListWordsDeleted({required this.dataToDeleted});
}

class ListWordsAdded extends ListWordsEvent {
  final NewWordInfo dataToAdded;

  ListWordsAdded({required this.dataToAdded});
}

class ListWordsRefresh extends ListWordsEvent {}
