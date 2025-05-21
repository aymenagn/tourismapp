import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:my_app/screens/activities/activitydetail_screen.dart';
import 'package:my_app/screens/activities/categories_activities_screen.dart';
import 'package:my_app/screens/hotels/hotels_screen.dart';
import 'package:my_app/screens/restaurants/restaurants_screen.dart';
import 'package:my_app/screens/restaurants/restaurants_screenn.dart';
import 'package:my_app/screens/restaurants/restaurants_screennn.dart';
import 'package:my_app/data/general.dart';
import 'package:my_app/widgets/contents/activities/categories_activitiesContent.dart';

class homeContent extends StatefulWidget {
  const homeContent({super.key});

  @override
  State<homeContent> createState() => _homeContentState();
}

class _homeContentState extends State<homeContent> {
  List<SpecialOffer> displeyOffer = [];
  int _currentOfferIndex = 0;

  //   Future<Position?> _getCurrentLocation(BuildContext context) async {
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Location permissions are denied')),
  //       );
  //       return null;
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text(
  //           'Location permissions are permanently denied, we cannot request permissions.',
  //         ),
  //       ),
  //     );
  //     return null;
  //   }

  //   // If permissions are granted, get the current position
  //   try {
  //     Position position = await Geolocator.getCurrentPosition();
  //     return position;
  //   } catch (e) {
  //     // Handle potential errors during location retrieval
  //     print("Error getting location: $e");
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Failed to get current location')),
  //     );
  //     return null;
  //   }
  // }

  //   void _navigateToRestaurants(BuildContext context) async {
  //   print("navigateToRestaurants called!"); // <--- This should print
  //   Position? position = await _getCurrentLocation(context);
  //   print("Current position: $position"); // <--- What does this print?
  //   if (position != null) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => const RestaurantsScreen()),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var _tool_ = MediaQuery.of(context).size.height;
    var _ord_ = MediaQuery.of(context).size.width;
    var tool = MediaQuery.of(context).size.height /785;
    var ord = MediaQuery.of(context).size.width/360;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => AlertDialog(content: Text('$_tool_ x $_ord_')),
                  );
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => RestaurantdetailScreen(),
                  //   ),
                  // );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: _tool_  * 0.0636942675159236,
                  width: _tool_  * 0.0636942675159236,
                  decoration: const BoxDecoration(
                    color: Color(0xff402662),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.tune, color: Colors.white70),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  height: _tool_  * 0.0636942675159236,
                  width: _tool_  * 0.0636942675159236,
                  decoration: const BoxDecoration(
                    color: Color(0xff402662),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.tune, color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    SizedBox(height: 15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Choices(
                          title: 'Hotels',
                          image: 'assets/images/hotel.png',
                          colorcontain: 0xff40354C,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HotelsScreen(),
                              ),
                            );
                          },
                        ),
                        Choices(
                          title: 'Restaurants',
                          image: 'assets/images/bag_2.png',
                          colorcontain: 0xff40354C,
                          onTap: () {
                            // _navigateToRestaurants(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RestaurantsScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Choices(
                          title: 'try',
                          image: 'assets/images/bag_3.png',
                          colorcontain: 0xff40354C,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => categoriesActivitiesContent(),
                              ),
                            );
                          },
                        ),
                        Choices(
                          title: 'Activities',
                          image: 'assets/images/activity.png',
                          colorcontain: 0xff40354C,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        const categoriesActivitiesScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                if (specialOffers.isNotEmpty) ...[
                  Padding(
                    padding:  EdgeInsets.symmetric(
                      horizontal: _ord_ *0.0444444444444444,
                      vertical: _tool_ *0.0103821656050955,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Special Offers',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('See All'),
                        ),
                      ],
                    ),
                  ),
                  CarouselSlider(
                    items:
                        specialOffers.map((offer) {
                          return Container(
                            margin:  EdgeInsets.symmetric(horizontal: _ord_ *0.0222222222222222),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey[200],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(10.0),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: '${offer.imageUrl}',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      placeholder:
                                          (context, url) => const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                      errorWidget:
                                          (context, url, error) =>
                                              const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        offer.title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        '${offer.description}',
                                        style: const TextStyle(fontSize: 12.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentOfferIndex = index;
                        });
                      },
                    ),
                  ),
                  if (specialOffers.length > 1)
                    Padding(
                      padding:  EdgeInsets.only(
                        top: _tool_  * 0.0101910828025478,
                        bottom: _tool_ *0.0203821656050955,
                      ),
                      child: Center(
                        child: DotsIndicator(
                          dotsCount: specialOffers.length,
                          // position: _currentOfferIndex,
                          decorator: DotsDecorator(
                            color: Colors.grey,
                            activeColor: Colors.purple,
                            size: const Size.square(8.0),
                            activeSize: const Size(16.0, 8.0),
                            activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
                const SizedBox(height: 15),
                const Row(
                  children: [
                    Expanded(
                      child: Text(
                        "The most searched bags ",
                        style: TextStyle(
                          fontSize: 19,
                          color: Color(0xff180226),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    InkWell(
                      child: Text(
                        "View all",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: _tool_  * 0.3707006369426752,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    //itemCount: bagList2.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          /*Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetail(bagList2[index])));*/
                        },
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                const SizedBox(height: 20),
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(20),
                                  height: _tool_  * 0.3185,
                                  width: _ord_  * 0.5555555555555556,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'bbbbb',
                                                  //bagList2[index].name,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  '2222',
                                                  //"${bagList2[index].price}\\-",
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: _ord_  * 0.1388888888888889,
                                            child: const Icon(
                                              Icons.favorite_outline,
                                              color: Color(0xff06c1cf),
                                              size: 30,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            /*Positioned(
                                left: 30,
                                child: SizedBox(
                                    height: _tool_ *0.2547770700636943,
                                      
                                    child: Image.asset(bagList2[index].image)))*/
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Choices extends StatelessWidget {
  const Choices({
    super.key,
    required this.title,
    required this.image,
    required this.colorcontain,
    required this.onTap,
  });
  final String title;
  final String image;
  final int colorcontain;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    var _tool_ = MediaQuery.of(context).size.height;
    var _ord_ = MediaQuery.of(context).size.width;
    var tool = MediaQuery.of(context).size.height /785;
    var ord = MediaQuery.of(context).size.width/360;
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: _tool_  * 0.1401273885350318,
        child: Stack(
          children: [
            Container(
              padding:  EdgeInsets.only(left: _ord_ *0.0416666666666667),
              height: _tool_  * 0.1146496815286624,
              width: _ord_  * 0.4166666666666667,
              decoration: BoxDecoration(
                color: Color(colorcontain),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFFE3DFF5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              right: 0,
              bottom: 0,
              child: SizedBox(
                height: _tool_  * 0.1146496815286624,
                width: _ord_  * 0.25,
                child: Image.asset(image),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
