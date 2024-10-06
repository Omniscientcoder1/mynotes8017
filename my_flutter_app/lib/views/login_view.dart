import 'package:flutter/material.dart';
import 'package:my_flutter_app/constants/routes.dart';
import 'package:my_flutter_app/services/auth/auth_exceptions.dart';
import 'package:my_flutter_app/services/auth/auth_service.dart';
import 'package:my_flutter_app/utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final email = _email.text;
    final password = _password.text;
    try {
      await AuthService.firebase().login(
        email: email,
        password: password,
      );
      final user = AuthService.firebase().currentUser;
      if (user?.isEmailVerified ?? false) {
        // User's email is verified
        if (!mounted) return; // Ensure widget is still mounted
        Navigator.of(context).pushNamedAndRemoveUntil(
          notesRoute,
          (route) => false,
        );
      } else {
        // User's email is not verified
        if (!mounted) return; // Ensure widget is still mounted
        Navigator.of(context).pushNamedAndRemoveUntil(
          verifyEmailRoute,
          (route) => false,
        );
      }
    } on UserNotFoundAuthException {
      if (!mounted) return;
      await showErrorDialog(
        context,
        'No user found for that email. Please register first.',
      );
    } on WrongPasswordAuthException {
      if (!mounted) return;
      await showErrorDialog(
        context,
        'Incorrect password. Please try again.',
      );
    } on GenericAuthException {
      if (!mounted) return;
      await showErrorDialog(
        context,
        'Authentication error',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 4.0,
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Enter your Email',
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Password',
            ),
          ),
          TextButton(
            onPressed: _login,
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              if (!mounted) return;
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: const Text('Not registered yet? Register here!'),
          ),
        ],
      ),
    );
  }
}
