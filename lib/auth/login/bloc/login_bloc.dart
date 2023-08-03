import 'package:bloc/bloc.dart';
import 'package:helper/auth/cubit/auth_cubit.dart';
import 'package:helper/auth/form_submission_status.dart';
import 'package:helper/data/modules.dart';
import 'package:helper/utils/api_helper.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthCubit authCubit;

  LoginBloc({required this.authCubit}) : super(LoginInitial()) {
    on<LoginUsernameChanged>((event, emit) {
      emit(state.copyWith(
          username: event.username, formStatus: const InitialFormStatus()));
    });

    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(
          password: event.password, formStatus: const InitialFormStatus()));
    });

    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));
      try {
        await ApiHelper.loginUser(
            LoginInfo(userName: state.username, password: state.password));
        emit(state.copyWith(formStatus: SubmissionSuccess()));

        authCubit.launchSession(state.username);
      } catch (exp) {
        emit(state.copyWith(formStatus: SubmissionFailed(exp as Exception)));
      }
    });
  }
}
