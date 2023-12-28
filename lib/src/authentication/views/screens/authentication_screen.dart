import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xms_app/src/authentication/bloc/authentication_bloc.dart';
import 'package:xms_app/src/authentication/views/widgets/login_section.dart';
import 'package:xms_app/src/authentication/views/widgets/register_section.dart';

enum AuthenticationRadioState {
  login,
  register,
}

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  AuthenticationRadioState? _radioState = AuthenticationRadioState.login;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void loginHandler() {
    context.read<AuthenticationBloc>().add(AuthenticationLogin(
      username: _usernameController.text.trim(), 
      password: _passwordController.text.trim(),
    ));
  }

  void registerHandler() {
    context.read<AuthenticationBloc>().add(AuthenticationRegister(
      username: _usernameController.text.trim(), 
      password: _passwordController.text.trim(),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationLoginFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            )
          );
        }
        else if (state is AuthenticationRegisterFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
        else if (state is AuthenticationRegisterSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Successfully created account, now you can login'),
            ),
          );
          setState(() {
            _radioState = AuthenticationRadioState.login;
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('XMS'),
          ),
          body: SafeArea(
            child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Login'),
                      leading: Radio<AuthenticationRadioState>(
                          value: AuthenticationRadioState.login,
                          groupValue: _radioState,
                          onChanged: (AuthenticationRadioState? value) {
                            setState(() {
                              _radioState = value;
                            });
                          }),
                    ),
                    _radioState == AuthenticationRadioState.login
                        ? LoginSection(
                            usernameController: _usernameController,
                            passwordController: _passwordController,
                            onLogin: loginHandler,
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      title: const Text('Register'),
                      leading: Radio<AuthenticationRadioState>(
                          value: AuthenticationRadioState.register,
                          groupValue: _radioState,
                          onChanged: (AuthenticationRadioState? value) {
                            setState(() {
                              _radioState = value;
                            });
                          }),
                    ),
                    _radioState == AuthenticationRadioState.register
                        ? RegisterSection(
                            usernameController: _usernameController,
                            passwordController: _passwordController,
                            onRegister: registerHandler,
                          )
                        : const SizedBox(),
                  ],
                )),
          ),
        );
      },
    );
  }
}
