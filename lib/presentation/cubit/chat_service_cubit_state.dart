part of 'chat_service_cubit.dart';

abstract class ChatServiceCubitState {}

class ChatServiceInitial extends ChatServiceCubitState {}

class ChatServiceLoading extends ChatServiceCubitState {}

class ChatServiceLoaded extends ChatServiceCubitState {
  final String messages;
  ChatServiceLoaded({required this.messages});
}
