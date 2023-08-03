part of 'get_data_cubit.dart';

@immutable
abstract class GetDataState {}

class UnkownGetDataState extends GetDataState {}

class UnauthGetDateState extends GetDataState {}

class LoadingData extends GetDataState {}

class LoadDataSuccessed extends GetDataState {
  final List<NewWordInfo> listWords;
  LoadDataSuccessed({required this.listWords});
}

class LoadDataFailed extends GetDataState {}
