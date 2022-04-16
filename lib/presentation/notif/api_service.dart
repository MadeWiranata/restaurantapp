import 'dart:convert';

import 'package:restaurantapp/presentation/notif/restaurant_not.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantNot> topHeadlines() async {
    final response = await http.get(Uri.parse(_baseUrl + 'list'));
    if (response.statusCode == 200) {
      return RestaurantNot.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
