import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xms_app/src/message/bloc/message_bloc.dart';
import 'package:xms_app/src/message/models/user_model.dart';
import 'package:xms_app/src/message/views/widgets/messages_pad.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({
    super.key,
  });

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  User _withUser = User(id: '', username: '');

  @override
  void initState() {
    super.initState();
  }

  void getMessages(User withUser) {
    context.read<MessageBloc>().add(MessageGetMessages(withUser: _withUser));
  }

  @override
  Widget build(BuildContext context) {
    _withUser = ModalRoute.of(context)!.settings.arguments as User;
    getMessages(_withUser);

    return BlocConsumer<MessageBloc, MessageState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text(_withUser.username)),
          body: (state is MessageLoading)
            ? const Center(child: CircularProgressIndicator(),)
            : (state is MessageGetSuccess)
              ? MessagesPad(
                messages: state.messages, 
                user: state.user, 
                withUser: state.withUser,
              )
              : const SizedBox()
        );
      },
    );
  }
}
