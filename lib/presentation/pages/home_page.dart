import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantapp/common/constants.dart';
import 'package:restaurantapp/common/state_enum.dart';
import 'package:restaurantapp/domain/entities/restaurants.dart';
import 'package:restaurantapp/presentation/pages/favorit_page.dart';
import 'package:restaurantapp/presentation/pages/restaurant_detail_page.dart';
import 'package:restaurantapp/presentation/pages/search_page.dart';
import 'package:restaurantapp/presentation/provider/restaurant_notifier.dart';

class HomePage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/home';

  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<RestaurantNotifier>(context, listen: false)
            .fetchRestaurant());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favorit'),
              onTap: () {
                Navigator.pushNamed(context, FavoritPage.ROUTE_NAME);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Restaurant'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<RestaurantNotifier>(builder: (context, data, child) {
                final state = data.state;
                if (state == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return RestaurantList(data.restaurant);
                } else {
                  return const Text('No Internet');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class RestaurantList extends StatelessWidget {
  final List<Restaurant> restaurants;

  // ignore: use_key_in_widget_constructors
  const RestaurantList(this.restaurants);

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      height: 770,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final restaurant = restaurants[index];
          return Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RestaurantDetailPage.ROUTE_NAME,
                  arguments: restaurant.id,
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        child: CachedNetworkImage(
                          imageUrl: '$BASE_IMAGE_URL${restaurant.pictureId}',
                          width: 100,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${restaurant.name}',
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.location_city_outlined),
                                  Text(
                                    '${restaurant.city}',
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    size: 17,
                                  ),
                                  Text(
                                    '${restaurant.rating}',
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: restaurants.length,
      ),
    );
  }
}
