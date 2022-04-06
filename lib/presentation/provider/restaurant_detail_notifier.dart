import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurantapp/common/state_enum.dart';
import 'package:restaurantapp/domain/entities/restaurants_detail.dart';
import 'package:restaurantapp/domain/usecase/get_favorit_status.dart';
import 'package:restaurantapp/domain/usecase/get_restaurant_detail.dart';
import 'package:restaurantapp/domain/usecase/remove_favorit.dart';
import 'package:restaurantapp/domain/usecase/save_favorit.dart';

class RestaurantDetailNotifier extends ChangeNotifier {
  static const favoritAddSuccessMessage = 'Added to Favorit';
  static const favoritRemoveSuccessMessage = 'Removed from Favorit';

  final GetRestaurantDetail getRestaurantDetail;
  final GetFavoritStatus getFavoritStatus;
  final SaveFavorit saveFavorit;
  final RemoveFavorit removeFavorit;

  RestaurantDetailNotifier({
    required this.getRestaurantDetail,
    required this.getFavoritStatus,
    required this.saveFavorit,
    required this.removeFavorit,
  });

  late RestaurantDetail _restaurant;
  RestaurantDetail get restaurant => _restaurant;

  RequestState _restaurantState = RequestState.Empty;
  RequestState get restaurantState => _restaurantState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoFavorit = false;
  bool get isAddedToFavorit => _isAddedtoFavorit;

  Future<void> fetchRestaurantDetail(String id) async {
    _restaurantState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getRestaurantDetail.execute(id);
    detailResult.fold(
      (failure) {
        _restaurantState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (restaurant) {
        _restaurant = restaurant;
        notifyListeners();
        _restaurantState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _favoritMessage = '';
  String get favoritMessage => _favoritMessage;

  Future<void> addFavorit(RestaurantDetail restaurant) async {
    final result = await saveFavorit.execute(restaurant);

    await result.fold(
      (failure) async {
        _favoritMessage = failure.message;
      },
      (successMessage) async {
        _favoritMessage = successMessage;
      },
    );

    await loadFavoritStatus(restaurant.id);
  }

  Future<void> removeFromFavorit(RestaurantDetail restaurant) async {
    final result = await removeFavorit.execute(restaurant);

    await result.fold(
      (failure) async {
        _favoritMessage = failure.message;
      },
      (successMessage) async {
        _favoritMessage = successMessage;
      },
    );

    await loadFavoritStatus(restaurant.id);
  }

  Future<void> loadFavoritStatus(String id) async {
    final result = await getFavoritStatus.execute(id);
    _isAddedtoFavorit = result;
    notifyListeners();
  }
}
