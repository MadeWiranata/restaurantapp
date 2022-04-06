import 'package:dartz/dartz.dart';
import 'package:restaurantapp/common/failure.dart';
import 'package:restaurantapp/domain/entities/restaurants_detail.dart';
import 'package:restaurantapp/domain/repositories/restaurant_repository.dart';

class SaveFavorit {
  final RestaurantRepository repository;

  SaveFavorit(this.repository);

  Future<Either<Failure, String>> execute(RestaurantDetail tv) {
    return repository.saveFavorit(tv);
  }
}
