// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurantapp/detail.dart';
import 'package:restaurantapp/restaurant.dart';
import 'package:restaurantapp/styles.dart';

class RestaurantPage extends StatelessWidget {
  static const routeName = '/restaurant_list';

  const RestaurantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
      ),
      body: FutureBuilder<String>(
        future:
            DefaultAssetBundle.of(context).loadString('assets/restorant.json'),
        builder: (context, snapshot) {
          final List<Restaurant> restaurants = parseRestaurants(snapshot.data);
          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              return _buildArticleItem(context, restaurants[index]);
            },
          );
        },
      ),
    );
  }
}

Widget _buildArticleItem(BuildContext context, Restaurant restaurant) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    leading: Image.network(
      restaurant.pictureId,
      width: 100,
    ),
    title: Text(
      restaurant.name,
      style: kHeading6,
    ),
    subtitle: new Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        new Row(
          children: [
            const Icon(Icons.location_city_outlined),
            Text(
              restaurant.city,
            ),
          ],
        ),
        new Row(
          children: [
            RatingBarIndicator(
              rating: restaurant.rating,
              itemCount: 5,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.pink,
              ),
              itemSize: 18,
            ),
            Text('${restaurant.rating}'),
          ],
        )
      ],
    ),
    onTap: () {
      Navigator.pushNamed(context, RestaurantDetailPage.routeName,
          arguments: restaurant);
    },
  );
}
