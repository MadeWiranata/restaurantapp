import 'package:equatable/equatable.dart';
import 'package:restaurantapp/domain/entities/customer_review.dart';

class RestaurantCustomerReviewsModel extends Equatable {
  const RestaurantCustomerReviewsModel({
    required this.name,
    required this.review,
    required this.date,
  });

  final String name;
  final String review;
  final String date;

  factory RestaurantCustomerReviewsModel.fromJson(Map<String, dynamic> json) =>
      RestaurantCustomerReviewsModel(
        name: json["name"],
        review: json["review"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "date": date,
      };

  CustomerReviews toEntity() {
    return CustomerReviews(
      name: name,
      review: review,
      date: date,
    );
  }

  @override
  List<Object?> get props => [
        name,
        review,
        date,
      ];
}
