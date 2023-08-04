part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class RegisterFormSubmitted extends RegisterEvent {
  final RegisterInfo registerInfo;
  RegisterFormSubmitted({required this.registerInfo});
}
