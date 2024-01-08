import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xms_app/src/message/bloc/message_bloc.dart';
import 'package:xms_app/src/message/models/user_model.dart';
import 'package:xms_app/src/message/sockets/message_socket.dart';
import 'package:xms_app/src/message/views/widgets/messages_pad.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MessageScreen extends StatefulWidget {
  const MessageScreen({
    super.key,
  });

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  User _withUser = User(id: '', username: '');
  TextEditingController messageController = TextEditingController();
  bool isSendButton = false;
  final messageSocket = MessageSocket();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // messageSocket.dispose();
  }

  void getMessages(User withUser) {
    context.read<MessageBloc>().add(MessageGetMessages(withUser: _withUser));
  }

  void sendMessage(User withUser, String message) {
    context.read<MessageBloc>().add(MessageSendMessage(
      textMessage: message,
      withUser: withUser,
    ));
  }

  void messageListener(MessageGetSuccess state) {
    messageSocket.messageListener(
      currentMessageGetSuccess: state, 
      onStateChanged: () {
        if (!mounted) {
          return;
        }
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _withUser = ModalRoute.of(context)!.settings.arguments as User;
    getMessages(_withUser);

    return BlocConsumer<MessageBloc, MessageState>(
      listener: (context, state) {
        if (state is MessageGetSuccess) {
          messageListener(state);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text(_withUser.username)),
          body: Column(
            children: [
              Expanded(
                child: (state is MessageLoading)
                  ? const Center(child: CircularProgressIndicator(),)
                  : (state is MessageGetSuccess)
                    ? MessagesPad(
                        messages: state.messages, 
                        user: state.user, 
                        withUser: state.withUser,
                      )
                    : const SizedBox(),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20, 
                    vertical: 10
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: messageController,
                          onChanged: (value) => isSendButton = value.isNotEmpty,
                          decoration: const InputDecoration(
                            hintText: 'Aa',
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => sendMessage(
                          _withUser, 
                          messageController.text.trim(),
                        ),
                        icon: const Icon(Icons.send), 
                        label: const Text('Send'),              
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        );
      },
    );
  }
}
