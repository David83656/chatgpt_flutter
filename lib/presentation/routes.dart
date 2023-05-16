import 'package:flutter/material.dart';

import 'cubit/chat_service_cubit.dart';
import 'pages/chat_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'chat': (_) => ChatPage(chatCubit: ChatServiceCubit()),
};
