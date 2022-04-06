import 'package:restaurantapp/common/exception.dart';
import 'package:restaurantapp/data/datasources/db/database_helper.dart';
import 'package:restaurantapp/data/models/restaurant_table.dart';

abstract class RestaurantLocalDataSource {
  Future<String> insertFavorit(RestaurantTable tv);
  Future<String> removeFavorit(RestaurantTable tv);
  Future<RestaurantTable?> getRestaurantById(String id);
  Future<List<RestaurantTable>> getFavoritRestaurant();
}

class RestaurantLocalDataSourceImpl implements RestaurantLocalDataSource {
  final DatabaseHelper databaseHelper;

  RestaurantLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertFavorit(RestaurantTable restaurant) async {
    try {
      await databaseHelper.insertFavorit(restaurant);
      return 'Added to Favorit';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeFavorit(RestaurantTable restaurant) async {
    try {
      await databaseHelper.removeFavorit(restaurant);
      return 'Removed from Favorit';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<RestaurantTable?> getRestaurantById(String id) async {
    final result = await databaseHelper.getRestaurantById(id);
    if (result != null) {
      return RestaurantTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<RestaurantTable>> getFavoritRestaurant() async {
    final result = await databaseHelper.getFavoritRestaurant();
    return result.map((data) => RestaurantTable.fromMap(data)).toList();
  }
}
