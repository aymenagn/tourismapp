import 'package:flutter/material.dart';
import 'package:my_app/screens/hotels/hotels_screen.dart';
import 'package:my_app/screens/restaurants/restaurants_screenn.dart';

// ignore: camel_case_types
class homeContent extends StatelessWidget {
  const homeContent({super.key});

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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 50,
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
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: Color(0xff402662),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.tune, color: Colors.white70),
                ),
              ),

              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0xFFE8DEF8),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        child: ListView(
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            // Header
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: Text('Cancel'),
                                ),
                                Text(
                                  'Filter',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text('Reset'),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),

                            // Sort By
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Sort By",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              value: 'Price Lower to Higher',
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              items:
                                  [
                                        'Price Lower to Higher',
                                        'Price Higher to Lower',
                                        'Rating Higher to Lower',
                                      ]
                                      .map(
                                        (value) => DropdownMenuItem(
                                          value: value,
                                          child: Text('\$ - \$\$  $value'),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (val) {},
                            ),
                            SizedBox(height: 20),

                            // Ratings
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Ratings",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(5, (index) {
                                int rating = index + 1;
                                bool isSelected = rating == 4;
                                return Container(
                                  width: 50,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color:
                                        isSelected
                                            ? Color(0xFF4A235A)
                                            : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        '$rating',
                                        style: TextStyle(
                                          color:
                                              isSelected
                                                  ? Colors.white
                                                  : Colors.black,
                                        ),
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 16,
                                        color:
                                            isSelected
                                                ? Colors.yellow
                                                : Colors.grey,
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                            SizedBox(height: 20),

                            // Price Range
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Price Ranges",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            RangeSlider(
                              values: RangeValues(90, 350),
                              min: 0,
                              max: 500,
                              divisions: 100,
                              activeColor: Color(0xFF4A235A),
                              onChanged: (values) {},
                            ),
                            Text("\$90 - \$350"),
                            SizedBox(height: 20),

                            // Apply Button
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF4A235A),
                                minimumSize: Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text("APPLY"),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 50,
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
                                builder:
                                    (context) => const RestaurantsScreenn(),
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
                          title: 'hotels',
                          image: 'assets/images/bag_3.png',
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
                          title: 'Activities',
                          image: 'assets/images/activity.png',
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
                      ],
                    ),
                  ],
                ),
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
                  height: 330,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 3, //bagList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          /*Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetail(bagList[index])));*/
                        },
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                const SizedBox(height: 20),
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(20),
                                  height: 250,
                                  width: 200,
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
                                                  //bagList[index].name,
                                                  'aaaaaaa',
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  '111111111',
                                                  // "${bagList[index].price}\\-",
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 50,
                                            child: Icon(
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
                                    height: 200,
                                    child: Hero(
                                      tag:bagList[index].image,
                                        child: Image.asset(bagList[index].image))))*/
                          ],
                        ),
                      );
                    },
                  ),
                ),
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
                  height: 290,
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
                                  height: 250,
                                  width: 200,
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
                                          const SizedBox(
                                            width: 50,
                                            child: Icon(
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
                                    height: 200,
                                      
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
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 110,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              height: 90,
              width: 150,
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
              child: SizedBox(height: 90, width: 90, child: Image.asset(image)),
            ),
          ],
        ),
      ),
    );
  }
}
