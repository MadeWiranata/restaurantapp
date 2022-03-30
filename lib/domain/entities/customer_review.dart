import 'package:equatable/equatable.dart';

class CustomerReviews extends Equatable {
  CustomerReviews({
    required this.name,
    required this.review,
    required this.date,
  });

  final String name;
  final String review;
  final String date;

  @override
  List<Object> get props => [
        name,
        review,
        date,
      ];
}
