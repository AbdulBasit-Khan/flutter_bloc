import 'package:flutter_blo/bloc/login/bloc/login_event.dart';
import 'package:flutter_blo/bloc/login/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginEvent>((event, emit) {});
  }
}
