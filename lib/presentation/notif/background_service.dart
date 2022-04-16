import 'dart:isolate';
import 'dart:ui';
import 'package:restaurantapp/main.dart';
import 'package:restaurantapp/presentation/notif/api_service.dart';
import 'package:restaurantapp/presentation/notif/notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  // ignore: prefer_const_declarations
  static final String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  static Future<void> callback() async {
    // ignore: avoid_print
    print('Alarm Fired!');
    final NotificationHelper _notificationHelper = NotificationHelper();
    var result = await ApiService().topHeadlines();
    await _notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  Future<void> someTask() async {
    // ignore: avoid_print
    print('Execute Some Process');
  }
}
