import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

part 'chat_service_cubit_state.dart';

class ChatServiceCubit extends Cubit<ChatServiceCubitState> {
  ChatServiceCubit() : super(ChatServiceInitial());
  //Method for send a message
  Future sendMessage(String data) async {
    String apiKey = "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";
    String baseUrl = "https://api.openai.com/v1/completions";
    if (data.isEmpty) {
      return emit(ChatServiceInitial());
    }
    var res = await http.post(Uri.parse(baseUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $apiKey"
        },
        body: json.encode({
          "model": "text-davinci-003",
          "prompt": data,
          "max_tokens": 200,
          "temperature": 0,
          "top_p": 1,
          "n": 1,
          "stream": false,
          "logprobs": null,
        }));
    if (res.statusCode == 200) {
      var res1 = jsonDecode(res.body);
      return emit(ChatServiceLoaded(messages: res1["choices"][0]["text"]));
    } else {
      return emit(ChatServiceLoading());
    }
  }
}
