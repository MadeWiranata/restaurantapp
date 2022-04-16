import 'dart:convert';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurantapp/presentation/notif/navigation.dart';
import 'package:restaurantapp/presentation/notif/restaurant_not.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();
  late int random;

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        print('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantNot restaurantResult) async {
    var _channelId = '1';
    var _channelName = "channel_01";
    var _channelDescription = "restaurant app channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: DefaultStyleInformation(true, true));

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    var titleNotification = "<b>Find Restaurant</b>";
    var restaurantLength = restaurantResult.restaurants.length;
    random = Random().nextInt(restaurantLength - 1);
    var titleRestaurant = restaurantResult.restaurants[random].name;

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleRestaurant, platformChannelSpecifics,
        payload: json.encode(restaurantResult.toJson()));
  }

  void configureSelectNotificationsSubject(String route) {
    selectNotificationSubject.stream.listen((String payload) async {
      var data = RestaurantNot.fromJson(json.decode(payload));
      var restaurant = data.restaurants[random];
      Navigation.intentWithData(route, restaurant.id);
    });
  }
}
