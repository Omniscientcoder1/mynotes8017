import 'package:flutter/material.dart';
import 'package:my_flutter_app/constants/routes.dart';
import 'package:my_flutter_app/services/auth/auth_exceptions.dart';
import 'package:my_flutter_app/services/auth/auth_service.dart';
import 'package:my_flutter_app/utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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

  Future<void> _register() async {
    final email = _email.text;
    final password = _password.text;

    try {
      // Call createUser method in AuthService
      await AuthService.firebase().createUser(
        email: email,
        password: password,
      );
      // Call sendEmailVerification method in AuthService
      await AuthService.firebase().sendEmailVerification();

      if (!mounted)
        return; // Ensure the widget is still mounted before navigation

      Navigator.of(context).pushNamed(verifyEmailRoute);
    } on WeakPasswordAuthException {
      if (!mounted) return;
      await showErrorDialog(context, 'Weak Password');
    } on EmailAlreadyInUseAuthException {
      if (!mounted) return;
      await showErrorDialog(context, 'Email already in use');
    } on InvalidEmailAuthException {
      if (!mounted) return;
      await showErrorDialog(context, 'Invalid email');
    } on GenericAuthException {
      if (!mounted) return;
      await showErrorDialog(context, 'Failed to Register');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register',
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
            onPressed: _register,
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              if (!mounted) return;
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            child: const Text('Already Registered? Login here'),
          ),
        ],
      ),
    );
  }
}
