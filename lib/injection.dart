import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:restaurantapp/data/datasources/restaurant_data_source.dart';
import 'package:restaurantapp/data/repositories/restaurant_repository_impl.dart';
import 'package:restaurantapp/domain/repositories/restaurant_repository.dart';
import 'package:restaurantapp/domain/usecase/get_restaurant.dart';
import 'package:restaurantapp/domain/usecase/get_restaurant_detail.dart';
import 'package:restaurantapp/domain/usecase/search_restaurant.dart';
import 'package:restaurantapp/presentation/provider/restaurant_detail_notifier.dart';
import 'package:restaurantapp/presentation/provider/restaurant_notifier.dart';
import 'package:restaurantapp/presentation/provider/restaurant_search_notifier.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => RestaurantNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => RestaurantDetailNotifier(
      getRestaurantDetail: locator(),
    ),
  );
  locator.registerFactory(
    () => RestaurantSearchNotifier(
      searchRestaurant: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetRestaurant(locator()));
  locator.registerLazySingleton(() => GetRestaurantDetail(locator()));
  locator.registerLazySingleton(() => SearchRestaurant(locator()));

  // repository
  locator.registerLazySingleton<RestaurantRepository>(
    () => RestaurantRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<RestaurantRemoteDataSource>(
      () => RestaurantRemoteDataSourceImpl(client: locator()));

  // external
  locator.registerLazySingleton(() => http.Client());
}
