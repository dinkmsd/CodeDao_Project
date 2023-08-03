import 'package:bloc/bloc.dart';
import 'package:helper/auth/abc/cubit/session_cubit.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SessionCubit sessionCubit;

  AuthCubit({required this.sessionCubit}) : super(AuthLogin());

  void showLogin() => emit(AuthLogin());
  void showSignUp() => emit(AuthSignUp());

  void launchSession(String username) {
    sessionCubit.startSession(username);
  }
}
