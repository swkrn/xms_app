import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:xms_app/utils/const_value.dart';

class SocketClient {
  io.Socket? socket;
  static SocketClient? _instance;

  SocketClient._internal() {
    socket = io.io(
      kBaseUrl, 
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': 'false',
      }
    );
    socket!.connect();
  }

  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}