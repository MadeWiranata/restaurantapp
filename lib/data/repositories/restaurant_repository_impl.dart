import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:restaurantapp/common/exception.dart';
import 'package:restaurantapp/common/failure.dart';
import 'package:restaurantapp/data/datasources/restaurant_data_source.dart';
import 'package:restaurantapp/data/datasources/restaurant_local_data_source.dart';
import 'package:restaurantapp/data/models/restaurant_table.dart';
import 'package:restaurantapp/domain/entities/restaurants.dart';
import 'package:restaurantapp/domain/entities/restaurants_detail.dart';
import 'package:restaurantapp/domain/repositories/restaurant_repository.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantRemoteDataSource remoteDataSource;
  final RestaurantLocalDataSource localDataSource;

  RestaurantRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Restaurant>>> getRestaurant() async {
    try {
      final result = await remoteDataSource.getRestaurant();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, RestaurantDetail>> getRestaurantDetail(
      String id) async {
    try {
      final restaurant = await remoteDataSource.getRestaurantDetail(id);
      return Right(restaurant.restaurant.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Restaurant>>> searchRestaurant(
      String query) async {
    try {
      final result = await remoteDataSource.searchRestaurant(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> saveFavorit(
      RestaurantDetail restaurant) async {
    try {
      final result = await localDataSource
          .insertFavorit(RestaurantTable.fromEntity(restaurant));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> removeFavorit(
      RestaurantDetail restaurant) async {
    try {
      final result = await localDataSource
          .removeFavorit(RestaurantTable.fromEntity(restaurant));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToFavorit(String id) async {
    final result = await localDataSource.getRestaurantById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<Restaurant>>> getFavoritRestaurant() async {
    final result = await localDataSource.getFavoritRestaurant();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
