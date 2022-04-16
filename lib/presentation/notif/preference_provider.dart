import 'package:flutter/material.dart';
import 'package:restaurantapp/presentation/notif/preference_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  bool _isDailyRestaurantActive = false;
  bool get isDailyRestaurantActive => _isDailyRestaurantActive;

  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getDailyRestaurantPreferences();
  }

  void _getDailyRestaurantPreferences() async {
    _isDailyRestaurantActive = await preferencesHelper.isDailyRestaurantActive;
    notifyListeners();
  }

  void enabledDailyNews(bool value) {
    preferencesHelper.setDailyRestaurant(value);
    _getDailyRestaurantPreferences();
  }
}
