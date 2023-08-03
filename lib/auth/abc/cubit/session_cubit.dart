import 'package:bloc/bloc.dart';
import 'package:helper/auth/auth_repository.dart';
import 'package:helper/data/user.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit() : super(UnknownSessionState()) {
    attemptAutoLogin();
  }

  void startSession(String username) async {
    try {
      User user = await AuthRepository.getUserInfo(username);
      emit(Authenticated(user: user));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('username', username);
    } catch (e) {
      print('Error auth');
      emit(Unauthenticated());
    }
  }

  void attemptAutoLogin() async {
    try {
      final username = await AuthRepository.loadUsername();
      if (username == '') {
        throw Exception('User not logged in');
      }
      User user = await AuthRepository.getUserInfo(username);
      emit(Authenticated(user: user));
    } on Exception {
      emit(Unauthenticated());
    }
  }

  void isAuthenticating() {
    emit(Authenticating());
  }

  void skipAuthentice() {
    emit(Unauthenticated());
  }

  void signOut() {
    AuthRepository.logout();
    emit(Unauthenticated());
  }
}
