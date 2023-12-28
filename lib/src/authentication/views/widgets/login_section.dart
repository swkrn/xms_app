import 'package:flutter/material.dart';

class LoginSection extends StatelessWidget {
  const LoginSection({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.onLogin,
  });

  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Username'
          ),
          controller: usernameController,
        ),
        const SizedBox(height: 10,),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Password',
          ),
          controller: passwordController,
        ),
        const SizedBox(height: 20,),
        ElevatedButton(
          onPressed: onLogin, 
          child: const Text('Login'),
        ),
      ],
    );
  }
}