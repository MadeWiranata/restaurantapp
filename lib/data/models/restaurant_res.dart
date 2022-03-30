import 'package:restaurantapp/data/models/restaurant_detail_model.dart';

class RestaurantListP {
  RestaurantListP({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  bool error;
  String message;
  RestaurantDetailResponse restaurant;

  factory RestaurantListP.fromJson(Map<String, dynamic> json) =>
      RestaurantListP(
        error: json["error"],
        message: json["message"],
        restaurant: RestaurantDetailResponse.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant.toJson(),
      };
}
