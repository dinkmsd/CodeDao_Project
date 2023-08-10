part of 'get_new_cubit.dart';

@immutable
sealed class GetNewState {}

final class GetNewInitial extends GetNewState {}

final class LoadingNew extends GetNewState {}

final class LoadedNewSuccess extends GetNewState {
  final List<NewInfo> listNews;
  LoadedNewSuccess({required this.listNews});
}

final class LoadedNewFailed extends GetNewState {}
