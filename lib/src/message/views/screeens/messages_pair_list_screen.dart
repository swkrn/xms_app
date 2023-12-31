import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xms_app/src/message/bloc/messages_list_bloc.dart';
import 'package:xms_app/src/message/views/widgets/messages_pair_list.dart';

class MessagesPairListScreen extends StatefulWidget {
  const MessagesPairListScreen({super.key});

  @override
  State<MessagesPairListScreen> createState() => _MessagesPairListScreenState();
}

class _MessagesPairListScreenState extends State<MessagesPairListScreen> {

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
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Messages'),),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {}, 
            icon: const Icon(Icons.send),
            label: const Text('Write a message')
          ),
          body: 
          (state is MessagesListLoading)
            ? const Center(child: CircularProgressIndicator(),)
            : (state is MessagesListLoadSuccess)             
              ? MessagesPairList(messagePairs: state.messagePairs, context: context,)
              : const SizedBox(),
        );
      },
    );
  }
}
