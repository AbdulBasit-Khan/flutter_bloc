import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              focusNode: emailFocusNode,
              decoration: const InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(),
              ),
              onChanged: (val) {},
              onFieldSubmitted: (val) {},
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              focusNode: passwordFocusNode,
              decoration: const InputDecoration(
                  hintText: "Password", border: OutlineInputBorder()),
              onChanged: (val) {},
              onFieldSubmitted: (val) {},
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(onPressed: () {}, child: const Text("Login"))
          ],
        ),
      ),
    );
  }
}
