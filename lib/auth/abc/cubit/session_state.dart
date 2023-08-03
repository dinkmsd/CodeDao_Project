part of 'session_cubit.dart';

@immutable
abstract class SessionState {}

class UnknownSessionState extends SessionState {}

class Unauthenticated extends SessionState {}

class Authenticating extends SessionState {}

class Authenticated extends SessionState {
  final User user;
  Authenticated({required this.user});
}
