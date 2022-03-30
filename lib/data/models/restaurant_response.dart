import 'package:equatable/equatable.dart';
import 'package:restaurantapp/data/models/restaurant_model.dart';

class RestaurantResponse extends Equatable {
  final List<RestaurantModel> restaurantList;

  RestaurantResponse({required this.restaurantList});

  factory RestaurantResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantResponse(
        restaurantList: List<RestaurantModel>.from((json["restaurants"] as List)
            .map((x) => RestaurantModel.fromJson(x))
            .where((element) => element.pictureId != null)),
      );

  Map<String, dynamic> toJson() => {
        "restaurants":
            List<dynamic>.from(restaurantList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [restaurantList];
}
