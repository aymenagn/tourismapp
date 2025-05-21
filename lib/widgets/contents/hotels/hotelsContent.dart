import 'package:flutter/material.dart';
import 'package:my_app/data/hotels.dart';
import 'package:my_app/screens/hotels/hoteldetail_screen.dart';

class hotelsContent extends StatefulWidget {
  const hotelsContent({super.key});

  @override
  _hotelsContentState createState() => _hotelsContentState();
}

class _hotelsContentState extends State<hotelsContent> {
  List<HotelsItems> displayedHotels = [];
  TextEditingController nameController = TextEditingController();
  String? selectedName;
  String? currentSearchQuery;
  List<String> nameSuggestions = [];
  bool isSearching = false;
  String? selectedCountry = 'All Countries';
  double _minRating = 1.0;
  RangeValues _priceRange = const RangeValues(0, 500);
  int? disaply;
  int? affNewWidget = 0;
  int? affhomeWidget = 1;
  int? affsearchTxt = 0;
  int? affOrder = 0;
  int? flechA = 0;
  int? flechR = 0;
  int? flechM = 0;
  // int? flechP = 0;
  // String _searchQuery = '';

  // void _onSearchChanged(String value) async {
  //   if (value.isNotEmpty) {
  //     setState(() {
  //       nameSuggestions =
  //           allHotels
  //               .where(
  //                 (hotel) => hotel.name!.toLowerCase().contains(
  //                   value.trim().toLowerCase(),
  //                 ),
  //               )
  //               .map((hotel) => hotel.name)
  //               .toList()
  //               .take(5)
  //               .whereType<String>()
  //               .toList();
  //     });
  //   } else {
  //     setState(() {
  //       currentSearchQuery = null;
  //       nameSuggestions.clear();
  //     });
  //   }
  // }

  void _applyFilters() {
    print("Applying filters...");

    List<HotelsItems> results = allHotels;

    print("Total hotels before filters: ${results.length}");

    // Filter by search query
    // if (currentSearchQuery!.isNotEmpty) {
    //   results =
    //       results
    //           .where(
    //             (h) => h.name!.toLowerCase().contains(
    //               currentSearchQuery!.toLowerCase(),
    //             ),
    //           )
    //           .toList();
    //   print("After search: ${results.length}");
    // }

    // Price range
    results =
        results
            .where(
              (h) =>
                  h.price! >= _priceRange.start && h.price! <= _priceRange.end,
            )
            .toList();
    print("After price filter: ${results.length}");

    // Rating filter
    if (_minRating > 0) {
      results = results.where((h) => h.rating! >= _minRating).toList();
      print("After rating filter: ${results.length}");
    }

    if (selectedCountry != 'All Countries') {
      results =
          results
              .where((hotel) => hotel.localisation!.contains(selectedCountry!))
              .toList();
      print("After country filter: ${results.length}");
    }

    // Sort
    // switch (selectedCountry) {
    //   case 'Price Lower to Higher':
    //     results.sort((a, b) => a.price!.compareTo(b.price as num));
    //     break;
    //   case 'Price Higher to Lower':
    //     results.sort((a, b) => b.price!.compareTo(a.price as num));
    //     break;
    //   case 'Rating Higher to Lower':
    //     results.sort((a, b) => b.rating!.compareTo(a.rating as num));
    //     break;
    // }
    setState(() {
      displayedHotels = results;
      affNewWidget = 1;
      affsearchTxt = 0;
      affhomeWidget = 0;
      affOrder = 1;
      flechA = 0;
      flechR = 0;
      flechM = 0;
      // flechP = 0;
    });
    print("Final filtered hotels count: ${displayedHotels.length}");
  }

  void _onSearchChanged(String value) async {
    setState(() {
      currentSearchQuery = value; // Track current search query
      nameSuggestions.clear();
      affNewWidget = 1;
      affhomeWidget = 0;
      affsearchTxt = 0;
      affOrder = 0;
    });

    if (value.isEmpty) {
      setState(() {
        displayedHotels.clear(); // Clear results when input is empty
        currentSearchQuery = null;
        affNewWidget = 0;
        affhomeWidget = 1;
        affsearchTxt = 0;
        affOrder = 0;
      });
      return;
    }

    // Filter hotels by name in real-time
    final filteredByName =
        allHotels
            .where(
              (hotel) => hotel.name!.toLowerCase().contains(
                value.trim().toLowerCase(),
              ),
            )
            .toList();

    setState(() {
      displayedHotels = filteredByName;
      affNewWidget = 1;
      affhomeWidget = 0;
      affsearchTxt = 0;
      affOrder = 0;
      flechA = 0;
      flechR = 0;
      flechM = 0;
      // flechP = 0;
    });

    // Optional: Show up to 5 name suggestions
    if (filteredByName.isNotEmpty) {
      setState(() {
        nameSuggestions =
            filteredByName.map((hotel) => hotel.name!).take(4).toList();
      });
    }
  }

  void _filterHotelssByVille(String ville) {
    setState(() {
      displayedHotels =
          allHotels
              .where((hotel) => hotel.localisation!.contains(ville))
              .toList();
      // allRestaurants
      //     .where(
      //       (restaurant) => restaurant.address.contains('$selectedLocation'),
      //     )
      //     .toList();
      // allRestaurants.sort((a, b) => b.rating.compareTo(a.rating));
    });
  }

  void _searchHotels(String query) {
    setState(() {
      selectedName = query;
      currentSearchQuery = query; // Save it for later filtering
      isSearching = true;
      displayedHotels.clear();
    });

    final filteredByName =
        allHotels
            .where(
              (hotel) => hotel.name!.toLowerCase().contains(
                query.trim().toLowerCase(),
              ),
            )
            .toList();
    setState(() {
      if (query.isNotEmpty) {
        displayedHotels = filteredByName;
        isSearching = false;
        affNewWidget = 1;
        affhomeWidget = 0;
        affsearchTxt = 1;
        affOrder = 0;
        flechA = 0;
        flechR = 0;
        flechM = 0;
        // flechP = 0;
      } else {
        affNewWidget = 0;
        affsearchTxt = 0;
        affhomeWidget = 1;
        affOrder = 0;
      }
    });

    // final filteredByCuisineAndName =
    //     selectedCuisine != null
    //         ? filteredByName
    //             .where((r) => r.cuisineType == selectedCuisine)
    //             .toList()
    //         : filteredByName;

    // if (filteredByCuisineAndName.isNotEmpty) {
    //   setState(() {
    //     displayedRestaurants = filteredByCuisineAndName;
    //     isSearching = false;
    //   });
    // } else {
    //   setState(() {
    //     displayedRestaurants.clear();
    //     isSearching = false;
    //   });
    //   ScaffoldMessenger.of(
    //     context,
    //   ).showSnackBar(SnackBar(content: Text('No matches for "$query"')));
    // }

    // else {
    //     setState(() {
    //       isSearching = false;
    //     });
    //   }
  }

  // void _dispAll() {
  //   setState(() {
  //     displayedHotels =
  //         allHotels
  //             .where(
  //               (hotel) => hotel.localisation!.contains('$currentSearchQuery'),
  //             )
  //             .toList();
  //   });
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
            children: [
              Expanded(
                child: Container(
                  // padding: const EdgeInsets.only(left: _ord_ *0.0277777777777778, right: _ord_ *0.0277777777777778),
                  alignment: Alignment.center,
                  height: _tool_ * 0.0636942675159236,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(86, 255, 255, 255),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Name Hotel :',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon:
                          nameController.text.isNotEmpty
                              ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  setState(() {
                                    affNewWidget = 0;
                                    affsearchTxt = 0;
                                    affhomeWidget = 1;
                                    affOrder = 0;
                                    nameController.clear();
                                    selectedName = null;
                                    currentSearchQuery =
                                        null; // Clear stored search
                                    displayedHotels.clear();
                                    nameSuggestions.clear();
                                  });
                                },
                              )
                              : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onChanged: _onSearchChanged,
                    onSubmitted: (value) {
                      _searchHotels(value);
                      setState(() {
                        nameSuggestions.clear();
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(width: 20),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(40),
                      ),
                    ),
                    builder: (BuildContext context) {
                      var _tool_ = MediaQuery.of(context).size.height;
                      return StatefulBuilder(
                        builder: (context, setModalState) {
                          return Container(
                            height: _tool_ / 1.7,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Color(0xFFE8DEF8),
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(40),
                              ),
                            ),
                            child: ListView(
                              // mainAxisSize: MainAxisSize.min,
                              shrinkWrap: true,
                              children: [
                                // Header
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
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
                                      onPressed: () {
                                        setModalState(() {
                                          _priceRange = const RangeValues(
                                            0,
                                            500,
                                          );
                                          _minRating = 0;
                                          selectedCountry = 'All Countries';
                                        });
                                        Navigator.pop(context);

                                        // _applyFilters();
                                        setState(() {
                                          affOrder = 0;
                                          affNewWidget = 0;
                                          affhomeWidget = 1;
                                          affsearchTxt = 0;
                                        });
                                      },
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
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                DropdownButtonFormField<String>(
                                  value: selectedCountry,
                                  decoration: InputDecoration(
                                    filled: false,
                                    // fillColor: const Color.fromARGB(98, 0, 0, 0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  items:
                                      countries.map((country) {
                                        return DropdownMenuItem(
                                          value: country,
                                          child: Text(country),
                                        );
                                      }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCountry = value!;
                                      // _applyFilters(); // We’ll define this function
                                    });
                                  },
                                ),
                                // DropdownButtonFormField<String>(
                                //   value: 'Price Lower to Higher',
                                //   decoration: InputDecoration(
                                //     filled: true,
                                //     fillColor: Colors.white,
                                //     border: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(10),
                                //     ),
                                //   ),
                                //   items:
                                //       [
                                //             'Price Lower to Higher',
                                //             'Price Higher to Lower',
                                //             'Rating Higher to Lower',
                                //           ]
                                //           .map(
                                //             (value) => DropdownMenuItem(
                                //               value: value,
                                //               child: Text('\$ - \$\$  $value'),
                                //             ),
                                //           )
                                //           .toList(),
                                //   onChanged: (val) {},
                                // ),
                                SizedBox(height: 20),

                                // Ratings
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Ratings",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.generate(5, (index) {
                                    int rating = index + 1;
                                    bool isSelected =
                                        rating == _minRating.toInt();
                                    return GestureDetector(
                                      onTap: () {
                                        setModalState(() {
                                          _minRating = rating.toDouble();
                                        });
                                        // _applyFilters();
                                      },
                                      child: Container(
                                        height: _tool_ * 0.0636942675159236,
                                        width: _ord_ * 0.1388888888888889,
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          color:
                                              isSelected
                                                  ? Color(0xFF4A235A)
                                                  : Colors.transparent,
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                          border: Border.all(
                                            color: Colors.grey,
                                          ),
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
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                RangeSlider(
                                  values: _priceRange,
                                  min: 0,
                                  max: 500,
                                  divisions: 100,
                                  activeColor: Color(0xFF4A235A),
                                  onChanged: (values) {
                                    setModalState(() {
                                      _priceRange = values;
                                    });
                                    // _applyFilters();
                                  },
                                ),
                                Text(
                                  "\$${_priceRange.start.toInt()} - \$${_priceRange.end.toInt()}",
                                ),
                                SizedBox(height: 20),

                                // Apply Button
                                SizedBox(
                                  height: _tool_ * 0.0636942675159236,
                                  width: _ord_ * 0.4166666666666667,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      nameSuggestions.clear();
                                      _applyFilters();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF4A235A),
                                      minimumSize: const Size(
                                        150,
                                        50,
                                      ), // Match SizedBox size
                                      maximumSize: const Size(150, 50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Text(
                                      "APPLY",
                                      style: TextStyle(
                                        color: Color(0xffffffff),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: _tool_ * 0.0636942675159236,
                  width: _ord_ * 0.1388888888888889,
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
        if (nameSuggestions.isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: nameSuggestions.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(nameSuggestions[index]),
                onTap: () {
                  setState(() {
                    nameController.text = nameSuggestions[index];
                    nameSuggestions.clear();
                  });
                  _searchHotels(nameController.text);
                },
              );
            },
          ),
        if (affsearchTxt == 1)
          Padding(
            padding:  EdgeInsets.only(
              top: _tool_ * 0.0254777070063694,
              left: _ord_ * 0.0555555555555556,
            ),
            child: const Row(
              children: [
                Text(
                  'Search : ',
                  style: TextStyle(
                    fontSize: 19,
                    color: Color(0xff180226),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        if (affOrder == 1)
          Padding(
            padding:  EdgeInsets.only(
              top: _tool_ * 0.0191082802547771,
              left: _ord_ * 0.0277777777777778,
              right: _ord_ * 0.0277777777777778,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Sort by Alphabet
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (displayedHotels.isNotEmpty) {
                          setState(() {
                            flechA = 1;
                            flechR = 0;
                            flechM = 0;
                            // flechP = 0;
                            // flechP = 0;
                            displayedHotels.sort(
                              (a, b) => a.name!.compareTo(b.name!),
                            );
                          });
                        }
                      },
                      icon: Icon(Icons.sort_by_alpha),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff402662),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    if (flechA == 1) Icon(Icons.arrow_drop_down),
                  ],
                ),
                SizedBox(width: 8),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (displayedHotels.isNotEmpty) {
                          setState(() {
                            flechA = 0;
                            flechR = 1;
                            flechM = 0;
                            // flechP = 0;
                            displayedHotels.sort(
                              (a, b) =>
                                  (b.rating ?? 0).compareTo(a.rating ?? 0),
                            );
                          });
                        }
                      },
                      icon: Icon(
                        Icons.star_purple500_sharp,
                        color: Colors.yellowAccent,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff402662),
                        padding: EdgeInsets.symmetric(vertical: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    if (flechR == 1) Icon(Icons.arrow_drop_down),
                  ],
                ),
                SizedBox(width: 8),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (displayedHotels.isNotEmpty) {
                          setState(() {
                            flechA = 0;
                            flechR = 0;
                            flechM = 1;
                            // flechP = 0;
                            displayedHotels.sort(
                              (a, b) => (a.price ?? 0).compareTo(b.price ?? 0),
                            );
                          });
                        }
                      },
                      icon: Icon(Icons.attach_money),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff402662),
                        foregroundColor: Colors.green.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    if (flechM == 1) Icon(Icons.arrow_drop_down),
                  ],
                ),
                // SizedBox(width: 8),
                // Column(
                //   children: [
                //     IconButton(
                //       onPressed: () {
                //         if (displayedHotels.isNotEmpty) {
                //           setState(() {
                //                 flechA = 0;
                //                 flechR = 0;
                //                 flechM = 2;
                //                 flechP=1;
                //             displayedHotels.sort(
                //               (a, b) => (a.price ?? 0).compareTo(b.price ?? 0),
                //             );
                //           });
                //         }
                //       },
                //       icon: Icon(Icons.attach_money),
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: Color(0xff402662),
                //         foregroundColor: Colors.green.shade700,
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(50),
                //         ),
                //       ),
                //     ),
                //     if (flechP == 1) Icon(Icons.arrow_drop_down),
                //   ],
                // ),
              ],
            ),
          ),
        SizedBox(height: 10),
        if (affhomeWidget == 1 || affNewWidget == 0)
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
                          "The most searched in Dubai : ",
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
                      itemCount:
                          allHotels
                              .where((h) => h.localisation!.contains('Dubai'))
                              .length,
                      itemBuilder: (context, index) {
                        final hotel =
                            allHotels
                                .where((h) => h.localisation!.contains('Dubai'))
                                .toList()[index];
                        return cardH(context, hotel);
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Row(
                    children: [
                      Expanded(
                        child: Text(
                          "The popular Hotels of Algeria : ",
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
                      itemCount:
                          allHotels
                              .where((h) => h.localisation!.contains('Algeria'))
                              .length,
                      itemBuilder: (context, index) {
                        final hotel =
                            allHotels
                                .where(
                                  (h) => h.localisation!.contains('Algeria'),
                                )
                                .toList()[index];
                        return cardH(context, hotel);
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Suggestions of Turkey : ",
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
                      itemCount:
                          allHotels
                              .where((h) => h.localisation!.contains('Turkey'))
                              .length,
                      itemBuilder: (context, index) {
                        final hotel =
                            allHotels
                                .where(
                                  (h) => h.localisation!.contains('Turkey'),
                                )
                                .toList()[index];
                        return cardH(context, hotel);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (affhomeWidget == 0 || affNewWidget == 1)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(
                      horizontal: _ord_ * 0.0444444444444444,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      // child: Row(
                      //   children: [
                      //     OutlinedButton(
                      //       onPressed: () async {
                      //         _isLocationEnabled =
                      //             await Geolocator.isLocationServiceEnabled();
                      //         if (!_isLocationEnabled) {
                      //           _filterNoCuisine();
                      //         } else {
                      //           if (currentSearchQuery != null &&
                      //               currentSearchQuery!.isNotEmpty) {
                      //             _allSearch();
                      //           } else {
                      //             // Normal behavior when no search is active
                      //             _dispAll();
                      //           }
                      //         }
                      //       },
                      //       child: const Text('All'),
                      //     ),
                      //     const SizedBox(width: 8.0),
                      //     OutlinedButton(
                      //       onPressed: () {
                      //         cuisPress('Italian');
                      //       },
                      //       child: const Text('Italian'),
                      //     ),
                      //     const SizedBox(width: 8.0),
                      //     OutlinedButton(
                      //       onPressed: () {
                      //         cuisPress('Mexican');
                      //       },
                      //       child: const Text('Mexican'),
                      //     ),
                      //     const SizedBox(width: 8.0),
                      //     OutlinedButton(
                      //       onPressed: () {
                      //         cuisPress('Chinese');
                      //       },
                      //       child: const Text('Chinese'),
                      //     ),
                      //     const SizedBox(width: 8.0),
                      //     OutlinedButton(
                      //       onPressed: () async {
                      //         _isLocationEnabled =
                      //             await Geolocator.isLocationServiceEnabled();
                      //         if (!_isLocationEnabled) {
                      //           _filterNoCuisine();
                      //           _checkLocationServicesAndPermissions();
                      //         } else {
                      //           if (currentSearchQuery != null &&
                      //               currentSearchQuery!.isNotEmpty) {
                      //             _Proximitysearch(36.1700, 5.70000);
                      //           } else {
                      //             _filterRestaurantsByProximity(36.1700, 5.70000);
                      //           }
                      //         }
                      //       },
                      //       child: const Text('Nearest'),
                      //     ),
                      //     const SizedBox(width: 8.0),
                      //     OutlinedButton(
                      //       onPressed: () {
                      //         // Implement logic for great offers
                      //       },
                      //       child: const Text('Great Offers'),
                      //     ),
                      //   ],
                      // ),
                    ),
                  ),
                  NewWidget(displayedHotels: displayedHotels),
                  if (displayedHotels.isEmpty && allHotels.isNotEmpty)
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'No restaurants found based on your criteria.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  if (allHotels.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'No restaurants available.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        //----------------------------------------------------------
        // if (displayedHotels.isEmpty && allHotels.isNotEmpty)
        //   const Padding(
        //     padding: EdgeInsets.all(16.0),
        //     child: Text(
        //       'No restaurants found based on your criteria.',
        //       style: TextStyle(fontSize: 16.0),
        //     ),
        //   ),
        // if (allHotels.isEmpty)
        //   const Padding(
        //     padding: EdgeInsets.all(16.0),
        //     child: Text(
        //       'No restaurants available.',
        //       style: TextStyle(fontSize: 16.0),
        //     ),
        //   ),
        // const SizedBox(height: 20.0),
        //------------------------------------------------------------
        //   Padding(
        //     padding: EdgeInsets.all(16.0),
        //     child: Text(
        //       'No Hotels found based on your Search : $currentSearchQuery',
        //       style: TextStyle(fontSize: 16.0),
        //     ),
        //   ),
        // if (allHotels.isEmpty)
        //   const Padding(
        //     padding: EdgeInsets.all(16.0),
        //     child: Text(
        //       'No restaurants available.',
        //       style: TextStyle(fontSize: 16.0),
        //     ),
        //   ),
        // const SizedBox(height: 20.0),
      ],
    );
  }

  GestureDetector cardH(BuildContext context, HotelsItems hotel) {
    var _tool_ = MediaQuery.of(context).size.height;
    var _ord_ = MediaQuery.of(context).size.width;
    var tool = MediaQuery.of(context).size.height /785;
    var ord = MediaQuery.of(context).size.width/360;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => HoteldetailScreen(hotel)),
        );
      },
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.all(10),
            padding:  EdgeInsets.only(
              top: _tool_ * 0.0127388535031847,
              left: _ord_ * 0.0277777777777778,
              right: _ord_ * 0.0277777777777778,
              bottom: 5,
            ),
            height: 263,
            width: _ord_ * 0.5916666666666667,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xff40354C),
            ),

            /*Positioned(
                              left: 30,
                              child: SizedBox(
                                  height: 200,
                                  child: Hero(
                                    tag:allHotels[index].image,
                                      child: Image.asset(allHotels[index].image))))*/
            child: Column(
              children: [
                Image.asset(
                  //'assets/images/hotel_1.png',
                  '${hotel.image}',
                  height: 124,
                  width: _ord_ * 0.5472222222222222,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Badges Row
                      Row(
                        children: [
                          _buildBadge(
                            //"10% OFF",
                            '${hotel.sold}',
                            background: Color(0xFF5D4CFF),
                          ),
                          SizedBox(width: 8),
                          _buildBadge(
                            //"⭐ 4.5",
                            '${hotel.rating}',
                            background: Color(0xFF403571),
                            showIcon: true,
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
                        '${hotel.name}',
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
                            '${hotel.localisation}',
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
                              style: TextStyle(color: Colors.grey),
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
  }

  Widget _buildBadge(
    String text, {
    required Color background,
    bool showIcon = false, // 👈 Optional parameter
  }) {
    var _tool_ = MediaQuery.of(context).size.height;
    var _ord_ = MediaQuery.of(context).size.width;
    var tool = MediaQuery.of(context).size.height /785;
    var ord = MediaQuery.of(context).size.width/360;
    return Container(
      height: 22,
      width: _ord_ * 0.1333333333333333,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showIcon) Icon(Icons.star, size: 12, color: Colors.yellow),
          if (showIcon)
            SizedBox(width: 4), // 👈 Add spacing between icon and text
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 8),
          ),
        ],
      ),
    );
  }
}
class NewWidget extends StatefulWidget {
  const NewWidget({super.key, required this.displayedHotels});

  final List<HotelsItems> displayedHotels;

  @override
  _NewWidgetState createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  @override
  Widget build(BuildContext context) {
    var _tool_ = MediaQuery.of(context).size.height;
    var _ord_ = MediaQuery.of(context).size.width;
    var tool = MediaQuery.of(context).size.height /785;
    var ord = MediaQuery.of(context).size.width/360;
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.displayedHotels.length,
      itemBuilder: (context, index) {
        final hotel = widget.displayedHotels[index];

        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => HoteldetailScreen(hotel)),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xff40354C), // Purple background
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            clipBehavior: Clip.hardEdge,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Restaurant Image
                Image.asset(
                  '${hotel.image}', // 👈 path to your asset
                  height: _tool_ * 0.1910828025477707,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                // Content Padding
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${hotel.name}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Colors.white, // White text for contrast
                        ),
                      ),
                      const SizedBox(height: 0),
                      Row(
                        children: [
                          _buildBadge(
                            //"10% OFF",
                            '${hotel.sold}',
                            background: Color(0xFF5D4CFF),
                          ),
                          SizedBox(width: 8),
                          _buildBadge(
                            //"⭐ 4.5",
                            '${hotel.rating}',
                            background: Color(0xFF403571),
                            showIcon: true,
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.favorite_border,
                              color: Color(0xFF5D4CFF),
                            ),
                          ),

                          // Text(
                          //   '(${restaurant.cuisineType})',
                          //   style: const TextStyle(
                          //     fontSize: 14.0,
                          //     color: Colors.white70,
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(height: 0),
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
                            '${hotel.localisation}',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 10,
                            ),
                          ),
                          Spacer(),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "\$${hotel.price}",
                                  style: const TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                const TextSpan(
                                  text: " /night",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // if (restaurant.distance != null)
                          //   Row(
                          //     mainAxisSize: MainAxisSize.min,
                          //     children: [
                          //       Icon(
                          //         Icons.location_on,
                          //         size: 16,
                          //         color: Colors.greenAccent,
                          //       ),
                          //       const SizedBox(width: 4),
                          //       Text(
                          //         '${restaurant.distance!.toStringAsFixed(2)} km',
                          //         style: const TextStyle(
                          //           fontSize: 14,
                          //           color: Colors.greenAccent,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Container _buildBadge(
    String text, {
    required Color background,
    bool showIcon = false, // 👈 Optional parameter
  }) {
    var _tool_ = MediaQuery.of(context).size.height;
    var _ord_ = MediaQuery.of(context).size.width;
    var tool = MediaQuery.of(context).size.height /785;
    var ord = MediaQuery.of(context).size.width/360;
    return Container(
      height: 22,
      width: _ord_ * 0.1333333333333333,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showIcon) Icon(Icons.star, size: 12, color: Colors.yellow),
          if (showIcon)
            SizedBox(width: 4), // 👈 Add spacing between icon and text
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 8),
          ),
        ],
      ),
    );
  }
}

// class StarWithArrowsIcon extends StatelessWidget {
//   final Color color;
//   final double size;

//   const StarWithArrowsIcon({
//     Key? key,
//     this.color = Colors.white,
//     this.size = 50.0,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: size,
//       height: size,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           // Star shape
//           Icon(Icons.star_rate_sharp, size: size * 1.1, color: color),

//           // Upward arrows
//           Positioned(
//             top: 30,
//             left: 0,
//             right: 60,
//             child: Stack(
//               children: [
//                 Positioned(
//                   top: 15,
//                   child: Transform.rotate(
//                     angle: pi, // Rotate 45 degrees
//                     child: Icon(
//                       Icons.arrow_drop_up_outlined,
//                       size: size * 1,
//                       color: color,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   child: Transform.rotate(
//                     angle: pi, // Rotate -45 degrees
//                     child: Icon(
//                       Icons.arrow_drop_down_outlined,
//                       size: size * 1,
//                       color: color,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
