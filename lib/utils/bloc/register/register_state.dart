part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterFormSubmitting extends RegisterState {}

class RegisterSuccessed extends RegisterState {
  final RegisterInfo registerInfo;
  RegisterSuccessed({required this.registerInfo});
}

class RegisterFailed extends RegisterState {
  final Exception exp;
  RegisterFailed({required this.exp});
}
