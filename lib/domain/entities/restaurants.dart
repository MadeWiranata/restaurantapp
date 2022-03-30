import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  Restaurant.watchlist({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
  });

  String? id;
  String? name;
  String? description;
  String? pictureId;
  String? city;
  double? rating;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        pictureId,
        city,
        rating,
      ];
}
