import 'package:dartz/dartz.dart';
import 'package:restaurantapp/common/failure.dart';
import 'package:restaurantapp/domain/entities/restaurants.dart';
import 'package:restaurantapp/domain/entities/restaurants_detail.dart';

abstract class RestaurantRepository {
  Future<Either<Failure, List<Restaurant>>> getRestaurant();
  Future<Either<Failure, RestaurantDetail>> getRestaurantDetail(String id);
  Future<Either<Failure, List<Restaurant>>> searchRestaurant(String query);
  Future<Either<Failure, String>> saveFavorit(RestaurantDetail tv);
  Future<Either<Failure, String>> removeFavorit(RestaurantDetail tv);
  Future<bool> isAddedToFavorit(String id);
  Future<Either<Failure, List<Restaurant>>> getFavoritRestaurant();
}
