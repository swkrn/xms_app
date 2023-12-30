import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xms_app/src/message/bloc/messages_list_bloc.dart';
import 'package:xms_app/src/message/views/widgets/messages_list.dart';

class MessagesListScreen extends StatefulWidget {
  const MessagesListScreen({super.key});

  @override
  State<MessagesListScreen> createState() => _MessagesListScreenState();
}

class _MessagesListScreenState extends State<MessagesListScreen> {

  @override
  void initState() {
    super.initState();
    getMessagePairs();
  }

  void getMessagePairs() {
    context.read<MessagesListBloc>().add(MessagesListGetPairs());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MessagesListBloc, MessagesListState>(
      listener: (context, state) {
        if (state is MessagesListNotAuthenticated) {
          Navigator.popAndPushNamed(context, '/auth');
        }
        if (state is MessagesListLoadFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Messages'),),
          body: 
          (state is MessagesListLoading)
            ? const Center(child: CircularProgressIndicator(),)
            : (state is MessagesListLoadSuccess)
              ? MessagesList(messagePairs: state.messagePairs)
              : const SizedBox(),
        );
      },
    );
  }
}
