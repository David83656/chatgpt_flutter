import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/chat_service_cubit.dart';

class ChatPage extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();
  final ChatServiceCubit chatCubit;
  ChatPage({super.key, required this.chatCubit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(132, 77, 87, 121),
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(65), child: _ChatAppbar()),
      body: BlocBuilder<ChatServiceCubit, ChatServiceCubitState>(
        bloc: chatCubit,
        builder: (context, state) {
          if (state is ChatServiceInitial) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.35,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.0),
                  ),
                ),
                _RequestTextField(textController: _textController),
                _SendPetitionButton(
                    chatCubit: chatCubit, textController: _textController)
              ],
            );
          }
          if (state is ChatServiceLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.35,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.0),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      state.messages.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
                _RequestTextField(textController: _textController),
                _SendPetitionButton(
                    chatCubit: chatCubit, textController: _textController)
              ],
            );
          }
          if (state is ChatServiceLoading) {
            return Column(children: [
              Center(
                heightFactor: MediaQuery.of(context).size.width / 40,
                child: const Text(
                  "Unnable to connect with the API please try in a few minutes.",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const CircularProgressIndicator(color: Colors.white),
            ]);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

//Privates Widgets//

//Petition Button
class _SendPetitionButton extends StatelessWidget {
  const _SendPetitionButton({
    required this.chatCubit,
    required TextEditingController textController,
  }) : _textController = textController;

  final ChatServiceCubit chatCubit;
  final TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white)),
        onPressed: () async {
          await chatCubit.sendMessage(_textController.text);
        },
        child: const Text(
          "Send",
          style: TextStyle(color: Colors.black),
        ));
  }
}

//Textfield petition
class _RequestTextField extends StatelessWidget {
  const _RequestTextField({
    required TextEditingController textController,
  }) : _textController = textController;

  final TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: TextField(
        decoration: const InputDecoration(
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            )),
        textAlign: TextAlign.start,
        controller: _textController,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

//APPBAR
class _ChatAppbar extends StatelessWidget {
  const _ChatAppbar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(132, 77, 87, 121),
      centerTitle: true,
      elevation: 1,
      title: Column(children: <Widget>[
        CircleAvatar(
          backgroundColor: const Color.fromRGBO(187, 222, 251, 1),
          maxRadius: 20,
          child: Image.network(
              "https://upload.wikimedia.org/wikipedia/commons/thumb/0/04/ChatGPT_logo.svg/250px-ChatGPT_logo.svg.png",
              fit: BoxFit.cover),
        ),
        const SizedBox(height: 3),
        const Text("ChatGPT",
            style: TextStyle(color: Colors.white, fontSize: 12))
      ]),
    );
  }
}
