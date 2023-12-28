import 'package:flutter/material.dart';

class RegisterSection extends StatelessWidget {
  const RegisterSection({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.onRegister,
    });

  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final VoidCallback onRegister;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Username',
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
          onPressed: onRegister, 
          child: const Text('Register'),
        ),
      ],
    );
  }
}