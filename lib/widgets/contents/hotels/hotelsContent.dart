import 'package:flutter/material.dart';
import 'package:my_app/data/hotels.dart';
import 'package:my_app/screens/hotels/hoteldetail_screen.dart';

class hotelsContent extends StatelessWidget {
  const hotelsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.black),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
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
                const SizedBox(height: 15),
                const Row(
                  children: [
                    Expanded(
                      child: Text(
                        "The most searched Hotels ",
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
                  height: 310,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: hotelsList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      HoteldetailScreen(hotelsList[index]),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.only(
                                top: 10,
                                left: 10,
                                right: 10,
                                bottom: 5,
                              ),
                              height: 263,
                              width: 213,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0xff40354C),
                              ),

                              /*Positioned(
                                left: 30,
                                child: SizedBox(
                                    height: 200,
                                    child: Hero(
                                      tag:hotelsList[index].image,
                                        child: Image.asset(hotelsList[index].image))))*/
                              child: Column(
                                children: [
                                  Image.asset(
                                    //'assets/images/hotel_1.png',
                                    hotelsList[index].image,
                                    height: 124,
                                    width: 197,
                                    fit: BoxFit.cover,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 0,
                                      horizontal: 5,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Badges Row
                                        Row(
                                          children: [
                                            _buildBadge(
                                              //"10% OFF",
                                              hotelsList[index].sold,
                                              background: Color(0xFF5D4CFF),
                                            ),
                                            SizedBox(width: 8),
                                            _buildBadge(
                                              //"⭐ 4.5",
                                              hotelsList[index].rate,
                                              background: Color(0xFF403571),
                                            ),
                                            Spacer(),
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.favorite_border,
                                                color: Color(0xFF5D4CFF),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Resort Name
                                        Text(
                                          //"AYANA Resort",
                                          hotelsList[index].name,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4),

                                        // Location
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 12,
                                              color: Colors.grey[400],
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              //"Bali, Indonesia",
                                              hotelsList[index].localisation,
                                              style: TextStyle(
                                                color: Colors.grey[400],
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8),

                                        // Price
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text:
                                                    //"${HotelsItems[index].price}\\-",
                                                    "\$200 - \$500 USD",
                                                style: TextStyle(
                                                  color: Colors.blueAccent,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                ),
                                              ),
                                              TextSpan(
                                                text: " /night",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                  height: 310,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: hotelsList2.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      HoteldetailScreen(hotelsList2[index]),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.only(
                                top: 10,
                                left: 10,
                                right: 10,
                                bottom: 5,
                              ),
                              height: 263,
                              width: 213,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0xff40354C),
                              ),

                              /*Positioned(
                                left: 30,
                                child: SizedBox(
                                    height: 200,
                                    child: Hero(
                                      tag:hotelsList2[index].image,
                                        child: Image.asset(hotelsList2[index].image))))*/
                              child: Column(
                                children: [
                                  Image.asset(
                                    //'assets/images/hotel_1.png',
                                    hotelsList2[index].image,
                                    height: 124,
                                    width: 197,
                                    fit: BoxFit.cover,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 0,
                                      horizontal: 5,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Badges Row
                                        Row(
                                          children: [
                                            _buildBadge(
                                              //"10% OFF",
                                              hotelsList2[index].sold,
                                              background: Color(0xFF5D4CFF),
                                            ),
                                            SizedBox(width: 8),
                                            _buildBadge(
                                              //"⭐ 4.5",
                                              hotelsList2[index].rate,
                                              background: Color(0xFF403571),
                                            ),
                                            Spacer(),
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.favorite_border,
                                                color: Color(0xFF5D4CFF),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Resort Name
                                        Text(
                                          //"AYANA Resort",
                                          hotelsList2[index].name,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4),

                                        // Location
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 12,
                                              color: Colors.grey[400],
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              //"Bali, Indonesia",
                                              hotelsList2[index].localisation,
                                              style: TextStyle(
                                                color: Colors.grey[400],
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8),

                                        // Price
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text:
                                                    //"${HotelsItems[index].price}\\-",
                                                    "\$200 - \$500 USD",
                                                style: TextStyle(
                                                  color: Colors.blueAccent,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                ),
                                              ),
                                              TextSpan(
                                                text: " /night",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                  height: 310,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: hotelsList3.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      HoteldetailScreen(hotelsList3[index]),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.only(
                                top: 10,
                                left: 10,
                                right: 10,
                                bottom: 5,
                              ),
                              height: 263,
                              width: 213,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0xff40354C),
                              ),

                              /*Positioned(
                                left: 30,
                                child: SizedBox(
                                    height: 200,
                                    child: Hero(
                                      tag:hotelsList3[index].image,
                                        child: Image.asset(hotelsList3[index].image))))*/
                              child: Column(
                                children: [
                                  Image.asset(
                                    //'assets/images/hotel_1.png',
                                    hotelsList3[index].image,
                                    height: 124,
                                    width: 197,
                                    fit: BoxFit.cover,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 0,
                                      horizontal: 5,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Badges Row
                                        Row(
                                          children: [
                                            _buildBadge(
                                              //"10% OFF",
                                              hotelsList3[index].sold,
                                              background: Color(0xFF5D4CFF),
                                            ),
                                            SizedBox(width: 8),
                                            _buildBadge(
                                              //"⭐ 4.5",
                                              hotelsList3[index].rate,
                                              background: Color(0xFF403571),
                                            ),
                                            Spacer(),
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.favorite_border,
                                                color: Color(0xFF5D4CFF),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Resort Name
                                        Text(
                                          //"AYANA Resort",
                                          hotelsList3[index].name,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4),

                                        // Location
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 12,
                                              color: Colors.grey[400],
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              //"Bali, Indonesia",
                                              hotelsList3[index].localisation,
                                              style: TextStyle(
                                                color: Colors.grey[400],
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8),

                                        // Price
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text:
                                                    //"${HotelsItems[index].price}\\-",
                                                    "\$200 - \$500 USD",
                                                style: TextStyle(
                                                  color: Colors.blueAccent,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                ),
                                              ),
                                              TextSpan(
                                                text: " /night",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
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

  Widget _buildBadge(String text, {required Color background}) {
    return Container(
      height: 22,
      width: 52,
      alignment: Alignment(0, 0),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 8),
      ),
    );
  }
}
