import 'package:flutter/cupertino.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class MessagesViewModel extends ChangeNotifier {
  PusherChannelsFlutter? pusher;

  MessagesViewModel() {
    _setUpClient();
  }

  void _setUpClient() async {
   // pusher = await getIt.getAsync<PusherChannelsFlutter>();
    await pusher!.connect();
  }

  @override
  void dispose() {
    pusher?.disconnect();
    super.dispose();
  }
}
