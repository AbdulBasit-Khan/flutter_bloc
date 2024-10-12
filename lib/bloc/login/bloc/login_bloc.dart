import 'dart:convert';

import 'package:flutter_blo/bloc/login/bloc/login_event.dart';
import 'package:flutter_blo/bloc/login/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginApi>(_loginApi);
  }
  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _loginApi(LoginApi event, Emitter<LoginState> emit) async {
    emit(state.copyWith(loginStatus: LoginStatus.loading));
    Map data = {'email': state.email, 'password': state.password};
    try {
      final response =
          await http.post(Uri.parse("https://reqres.in/api/login"), body: data);
      var data1 = jsonDecode(response.body);
      if (response.statusCode == 200) {
        emit(state.copyWith(
            message: "login successful", loginStatus: LoginStatus.success));
      } else {
        emit(state.copyWith(
            message: data1['error'], loginStatus: LoginStatus.error));
      }
    } catch (e) {
      emit(state.copyWith(
          message: e.toString(), loginStatus: LoginStatus.error));
    }
  }
}
