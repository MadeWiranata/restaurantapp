import 'package:equatable/equatable.dart';
import 'package:restaurantapp/data/models/restaurant_menus_model.dart';
import 'package:restaurantapp/domain/entities/categories.dart';
import 'package:restaurantapp/domain/entities/customer_review.dart';
import 'package:restaurantapp/domain/entities/menus.dart';

class RestaurantDetail extends Equatable {
  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.rating,
    required this.categories,
    required this.menus,
    required this.customerReviews,
  });

  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  double rating;
  List<Categories> categories;
  RestaurantMenusModel menus;
  List<CustomerReviews> customerReviews;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        city,
        address,
        pictureId,
        rating,
        categories,
        menus,
        customerReviews,
      ];
}
