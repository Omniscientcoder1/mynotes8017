import 'package:flutter/material.dart';
import 'package:my_flutter_app/constants/routes.dart';
import 'package:my_flutter_app/services/auth/auth_service.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: Column(
        children: [
          const Text('We have sent a verification email to your account.'),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().sendEmailVerification();
            },
            child: const Text('Resend Verification Email'),
          ),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().logout();

              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (_) => false,
              );
            },
            child: const Text('Go back to register'),
          ),
        ],
      ),
    );
  }
}
