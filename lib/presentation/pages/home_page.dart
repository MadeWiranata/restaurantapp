import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantapp/common/constants.dart';
import 'package:restaurantapp/common/state_enum.dart';
import 'package:restaurantapp/domain/entities/restaurants.dart';
import 'package:restaurantapp/presentation/pages/restaurant_detail_page.dart';
import 'package:restaurantapp/presentation/pages/search_page.dart';
import 'package:restaurantapp/presentation/provider/restaurant_notifier.dart';

class HomePage extends StatefulWidget {
  static const ROUTE_NAME = '/home';
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
      appBar: AppBar(
        title: Text('ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              Consumer<RestaurantNotifier>(builder: (context, data, child) {
                final state = data.state;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return RestaurantList(data.restaurant);
                } else {
                  return Text('Failed');
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

  RestaurantList(this.restaurants);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final restaurant = restaurants[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RestaurantDetailPage.ROUTE_NAME,
                  arguments: restaurant.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${restaurant.pictureId}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: restaurants.length,
      ),
    );
  }
}
