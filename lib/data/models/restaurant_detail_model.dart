// ignore_for_file: non_constant_identifier_names, unnecessary_this, must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:restaurantapp/data/models/restaurant_categories_model.dart';
import 'package:restaurantapp/data/models/restaurant_customer_review_model.dart';
import 'package:restaurantapp/data/models/restaurant_menus_model.dart';
import 'package:restaurantapp/domain/entities/restaurants_detail.dart';

class RestaurantDetailResponse extends Equatable {
  RestaurantDetailResponse({
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
  String rating;
  List<RestaurantCategoriesModel> categories;
  RestaurantMenusModel menus;
  List<RestaurantCustomerReviewsModel> customerReviews;

  factory RestaurantDetailResponse.fromJson(Map<String, dynamic> restaurant) =>
      RestaurantDetailResponse(
        id: restaurant["id"],
        name: restaurant["name"],
        description: restaurant["description"],
        city: restaurant["city"],
        address: restaurant["address"],
        pictureId: restaurant["pictureId"],
        rating: restaurant["rating"].toString(),
        categories: List<RestaurantCategoriesModel>.from(
            restaurant["categories"]
                .map((x) => RestaurantCategoriesModel.fromJson(x))),
        menus: RestaurantMenusModel.fromJson(restaurant["menus"]),
        customerReviews: List<RestaurantCustomerReviewsModel>.from(
            restaurant["customerReviews"]
                .map((x) => RestaurantCustomerReviewsModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "city": city,
        "address": address,
        "pictureId": pictureId,
        "rating": rating,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "menus": menus.toJson(),
        "customerReviews":
            List<dynamic>.from(customerReviews.map((x) => x.toJson())),
      };

  RestaurantDetail toEntity() {
    return RestaurantDetail(
      id: this.id,
      name: this.name,
      description: this.description,
      city: this.city,
      address: this.address,
      pictureId: this.pictureId,
      rating: this.rating,
      categories:
          this.categories.map((Categories) => Categories.toEntity()).toList(),
      menus: this.menus,
      customerReviews: this
          .customerReviews
          .map((CustomerReviews) => CustomerReviews.toEntity())
          .toList(),
    );
  }

  @override
  // ignore: todo
  // TODO: implement props
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
