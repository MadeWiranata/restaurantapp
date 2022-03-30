import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurantapp/common/exception.dart';
import 'package:restaurantapp/data/models/restaurant_model.dart';
import 'package:restaurantapp/data/models/restaurant_res.dart';
import 'package:restaurantapp/data/models/restaurant_response.dart';

abstract class RestaurantRemoteDataSource {
  Future<List<RestaurantModel>> getRestaurant();
  Future<RestaurantListP> getRestaurantDetail(String id);
  Future<List<RestaurantModel>> searchRestaurant(String query);
}

class RestaurantRemoteDataSourceImpl implements RestaurantRemoteDataSource {
  static const BASE_URL = 'https://restaurant-api.dicoding.dev';

  final http.Client client;

  RestaurantRemoteDataSourceImpl({required this.client});

  @override
  Future<List<RestaurantModel>> getRestaurant() async {
    final response = await client.get(Uri.parse('$BASE_URL/list'));

    if (response.statusCode == 200) {
      return RestaurantResponse.fromJson(json.decode(response.body))
          .restaurantList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<RestaurantListP> getRestaurantDetail(String id) async {
    final response = await client.get(Uri.parse('$BASE_URL/detail/$id'));

    if (response.statusCode == 200) {
      return RestaurantListP.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<RestaurantModel>> searchRestaurant(String query) async {
    final response = await client.get(Uri.parse('$BASE_URL/search?q=$query'));

    if (response.statusCode == 200) {
      return RestaurantResponse.fromJson(json.decode(response.body))
          .restaurantList;
    } else {
      throw ServerException();
    }
  }
}
