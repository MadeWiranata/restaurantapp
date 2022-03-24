// ignore_for_file: unnecessary_new, unnecessary_const

import 'package:flutter/material.dart';
import 'package:restaurantapp/restaurant.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;
  // ignore: use_key_in_widget_constructors
  const RestaurantDetailPage({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(restaurant.pictureId),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Row(
                        children: [
                          const Icon(Icons.location_city_outlined),
                          Text(
                            restaurant.city,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Text(
                    'Deskripsi',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  Text(
                    restaurant.description,
                  ),
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 10),
                  new Column(
                    children: [
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Menu',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(color: Colors.grey),
                  new Column(
                    children: [
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            'Foods',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  new Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: restaurant.menus.foods
                              .map((makan) => Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 8),
                                  child: Card(
                                      child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(makan.name),
                                  ))))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                  new Column(
                    children: [
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            'Drinks',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  new Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: restaurant.menus.drinks
                              .map((minuman) => Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 8),
                                  child: Card(
                                      child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(minuman.name),
                                  ))))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
