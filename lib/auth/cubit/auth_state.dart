part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLogin extends AuthState {}

class AuthSignUp extends AuthState {}
