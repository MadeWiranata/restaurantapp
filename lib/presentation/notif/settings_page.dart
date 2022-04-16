import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantapp/presentation/notif/preference_provider.dart';
import 'package:restaurantapp/presentation/notif/sc_provider.dart';

class SettingsPage extends StatelessWidget {
  static const String settingsTitle = 'Settings';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PreferencesProvider>(
          builder: (context, provider, child) {
            return ListView(
              children: [
                Material(
                  child: ListTile(
                    title: const Text('Notification'),
                    trailing: Consumer<SchedulingProvider>(
                      builder: (context, scheduled, _) {
                        return Switch.adaptive(
                            value: provider.isDailyRestaurantActive,
                            onChanged: (value) async {
                              scheduled.scheduledRestaurant(value);
                              provider.enabledDailyNews(value);
                            });
                      },
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
