import 'package:flutter/material.dart';
import 'package:flutter_blo/bloc/login/bloc/login_bloc.dart';
import 'package:flutter_blo/bloc/login/bloc/login_event.dart';
import 'package:flutter_blo/bloc/login/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc _loginBloc;
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocProvider(
        create: (context) => _loginBloc,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<LoginBloc, LoginState>(
                buildWhen: (current, previous) =>
                    current.email != previous.email,
                builder: (context, state) {
                  return TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    focusNode: emailFocusNode,
                    decoration: const InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (val) {
                      context.read<LoginBloc>().add(EmailChanged(email: val));
                    },
                    onFieldSubmitted: (val) {},
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<LoginBloc, LoginState>(
                buildWhen: (current, previous) =>
                    current.password != previous.password,
                builder: (context, state) {
                  return TextFormField(
                    keyboardType: TextInputType.text,
                    focusNode: passwordFocusNode,
                    decoration: const InputDecoration(
                        hintText: "Password", border: OutlineInputBorder()),
                    onChanged: (val) {
                      context
                          .read<LoginBloc>()
                          .add(PasswordChanged(password: val));
                    },
                    onFieldSubmitted: (val) {},
                  );
                },
              ),
              const SizedBox(
                height: 50,
              ),
              BlocBuilder<LoginBloc, LoginState>(
                buildWhen: (current, previous) => false,
                builder: (context, state) {
                  return ElevatedButton(
                      onPressed: () {
                        // context.read<LoginBloc>().add(LoginEvent());
                      }, child: const Text("Login"));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
