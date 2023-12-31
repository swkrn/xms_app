import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xms_app/src/authentication/bloc/authentication_bloc.dart';
import 'package:xms_app/src/authentication/views/screens/authentication_screen.dart';
import 'package:xms_app/src/message/bloc/message_bloc.dart';
import 'package:xms_app/src/message/bloc/messages_list_bloc.dart';
import 'package:xms_app/src/message/views/screeens/message_screen.dart';
import 'package:xms_app/src/message/views/screeens/messages_pair_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XMS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthenticationBloc(),),
        ],
        child: const AuthenticationScreen(),
      ),
      routes: {
        '/auth': (context) => BlocProvider(
          create: (context) => AuthenticationBloc(),
          child: const AuthenticationScreen(),
        ),
        '/messages-list': (context) => BlocProvider(
          create: (context) => MessagesListBloc(),
          child: const MessagesPairListScreen(),
        ),
        '/message': (context) => BlocProvider(
          create:(context) => MessageBloc(),
          child: const MessageScreen(),
        ),
      },
    );
  }
}
