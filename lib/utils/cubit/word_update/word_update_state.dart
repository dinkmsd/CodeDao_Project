part of 'word_update_cubit.dart';

@immutable
abstract class WordUpdateState {}

class WordUpdateInitial extends WordUpdateState {}

class WordUpdating extends WordUpdateState {}

class WordUpdateSuccessed extends WordUpdateState {
  final NewWordInfo newWordInfo;
  WordUpdateSuccessed({required this.newWordInfo});
}

class WordDeleteSuccessed extends WordUpdateState {}

class WordUpdateFailed extends WordUpdateState {}
