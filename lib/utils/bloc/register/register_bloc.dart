import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:helper/data/modules.dart';
import 'package:helper/utils/auth/auth_repository.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterFormSubmitted>((event, emit) async {
      emit(RegisterFormSubmitting());
      try {
        await AuthRepository.submitRegister(event.registerInfo);
        emit(RegisterSuccessed(registerInfo: event.registerInfo));
      } catch (exp) {
        emit(RegisterFailed(exp: exp as Exception));
      }
    });
  }
}
