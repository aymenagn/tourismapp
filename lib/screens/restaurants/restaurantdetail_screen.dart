import 'package:flutter/material.dart';
import 'package:my_app/data/restaurants.dart';

class RestaurantdetailScreen extends StatefulWidget {
  RestaurantItems itemR;
  RestaurantdetailScreen(this.itemR, {super.key});

  @override
  State<RestaurantdetailScreen> createState() => _RestaurantdetailScreenState();
}

class _RestaurantdetailScreenState extends State<RestaurantdetailScreen>
    with SingleTickerProviderStateMixin {
  bool isfav = false;
  late AnimationController _animationController;
  //this is used for animation
  late Animation<Color?> _coloranimation;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _coloranimation = ColorTween(
      begin: Colors.grey[400],
      end: Colors.red,
    ).animate(_animationController);
    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(tween: Tween(begin: 30, end: 50), weight: 50),
      TweenSequenceItem<double>(tween: Tween(begin: 50, end: 30), weight: 50),
    ]).animate(_animationController);
    //this is used to listen any change in animation
    _animationController.addListener(() {});
    //this is used in listening the controller status it is done or not
    _animationController.addStatusListener((status) {
      //here we changing the bool value depending on  status
      if (status == AnimationStatus.completed) {
        setState(() {
          isfav = true;
        });
      }
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isfav = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _tool_ = MediaQuery.of(context).size.height;
    var _ord_ = MediaQuery.of(context).size.width;
    var tool = MediaQuery.of(context).size.height /785;
    var ord = MediaQuery.of(context).size.width/360;
    return Scaffold(
      backgroundColor: Color(0xFFE3DFF5),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        backgroundColor: Color(0xff40354C),
        title: Text(
          widget.itemR.name,
          style: const TextStyle(
            color: Color(0xFFE3DFF5),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Padding(
            padding: EdgeInsets.all(5),
            child: Icon(Icons.arrow_back_ios, color: Color(0xFFE3DFF5)),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black),
            onPressed: () {
              // Handle share action
              /*Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ConfirmationbookingScreen( // Use the new screen here
                        bookingDate: bookingDate,
                        checkInDate: checkInDate,
                        checkOutDate: checkOutDate,
                        adults: _adults,
                        children: _children,
                        rooms: _rooms,
                        totalPrice: _totalPrice,
                        ),          
                ),
              );*/
            },
          ),
          AnimatedBuilder(
            animation: _animationController,
            builder: (BuildContext context, _) {
              return IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: _coloranimation.value,
                  size: _sizeAnimation.value,
                ),
                onPressed: () {
                  isfav
                      ? _animationController.reverse()
                      : _animationController.forward();
                },
              );
            },
          ),
        ],
      ),
      body: SizedBox(
        height: _tool_,
        child: Stack(
          children: [
            // Header Section
            _buildHeaderSection(),

            Positioned.fill(
              top: 0,
              left: 0,
              right: 0,
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      height: _tool_ * 0.3185,
                      alignment: Alignment.bottomRight,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Color.fromARGB(255, 39, 32, 46).withOpacity(1),
                            Color.fromARGB(255, 0, 0, 0).withOpacity(0),
                          ],
                          stops: [0.05, 0.5],
                        ),
                      ),
                    ),

                    // Restaurant Information
                    Padding(
                      padding: EdgeInsets.only(top: _tool_ * 0.2936),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFE8DEF8),
                          // Background color
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30),
                          ), // Rounded corners
                        ),

                        child: Column(
                          children: [
                            _buildRestaurantInfo(),

                            // Tabs
                            _buildTabs(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Header Section
  Widget _buildHeaderSection() {
    var _tool_ = MediaQuery.of(context).size.height;
    var _ord_ = MediaQuery.of(context).size.width;
    var tool = MediaQuery.of(context).size.height /785;
    var ord = MediaQuery.of(context).size.width/360;
    return Stack(
      children: [
        // Banner Image
        SizedBox(
          child: Image.network(
            widget.itemR.imageUrl,
            // width: MediaQuery.of(context).size.width * 0.75,
            width: _ord_,
            height: _tool_ * 0.3185,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.error, color: Colors.red, size: 40),
                    SizedBox(height: 8),
                    Text(
                      'Image not available',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        // Thumbnails
        Positioned(
          left: _ord_ * 0.7,
          child: SizedBox(
            width: _ord_ * 0.25,
            height: _tool_ * 0.3185,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 3,
              padding: EdgeInsets.only(bottom: 8),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 10,
                        blurRadius: 20,
                        offset: Offset(2, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        widget.itemR.imageUrl,
                        width: _ord_ * 0.1944444444444444,
                        height: _tool_ * 0.089171974522293,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.error, color: Colors.red, size: 40),
                                SizedBox(height: 8),
                                Text(
                                  'Image not available',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  // Restaurant Information
  Widget _buildRestaurantInfo() {
    var _tool_ = MediaQuery.of(context).size.height;
    var _ord_ = MediaQuery.of(context).size.width;
    var tool = MediaQuery.of(context).size.height /785;
    var ord = MediaQuery.of(context).size.width/360;
    return Padding(
      padding: EdgeInsets.only(
        top: _tool_ * 0.0254777070063694,
        right: _ord_ * 0.0555555555555556,
        left: _ord_ * 0.0555555555555556,
        bottom: _tool_ * 0.0127388535031847,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Offer
          // Row(
          //   children: [
          //     Icon(Icons.local_offer, color: Colors.green),
          //     SizedBox(width: 4),
          //     Text(
          //       '${widget.itemR.rating}',
          //       style: TextStyle(color: Colors.green),
          //     ),
          //   ],
          // ),
          // SizedBox(height: 8),

          // Restaurant Name
          Text(
            widget.itemR.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber),
                  SizedBox(width: 4),
                  Text('${widget.itemR.rating}'),
                ],
              ),
              SizedBox(width: 16),
              Row(
                children: [
                  Icon(Icons.access_time, size: 16),
                  SizedBox(width: 4),
                  Text('15 min'),
                ],
              ),
              SizedBox(width: 16),
              Row(
                children: [
                  Icon(Icons.restaurant, size: 16),
                  SizedBox(width: 4),
                  Text(widget.itemR.cuisineType),
                ],
              ),
            ],
          ),
          SizedBox(height: 4),

          // Address
          Row(
            children: [
              Icon(Icons.location_on, size: 16),
              SizedBox(width: 4),
              Text(widget.itemR.address),
            ],
          ),
        ],
      ),
    );
  }

  // Tabs
  Widget _buildTabs() {
    var _tool_ = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          TabBar(
            indicatorColor: Color(0xFF4A235A),
            labelColor: Color(0xFF4A235A),
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Menu'),
              Tab(text: 'About'),
              Tab(text: 'Gallery'),
              Tab(text: 'Reviews'),
            ],
          ),
          SizedBox(
            height: _tool_ * 0.61,
            child: TabBarView(
              children: [
                _buildContent(build_: Menu()),
                _buildContent(build_: About()),
                _buildContent(build_: Gallery()),
                _buildContent(build_: Reviews()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Menu Content
  Widget _buildContent({required Widget build_}) {
    return Padding(padding: EdgeInsets.all(16), child: build_);
  }

  Column Menu() {
    var _tool_ = MediaQuery.of(context).size.height;
    var _ord_ = MediaQuery.of(context).size.width;
    var tool = MediaQuery.of(context).size.height /785;
    var ord = MediaQuery.of(context).size.width/360;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Menu Title
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       'Menu (86 Items)',
        //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        //     ),
        //     ElevatedButton(onPressed: () {}, child: Text('View Full Menu')),
        //   ],
        // ),
        // SizedBox(height: 16),

        // Search Bar
        // TextField(
        //   decoration: InputDecoration(
        //     prefixIcon: Icon(Icons.search),
        //     hintText: 'Search items',
        //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        //   ),
        // ),
        // SizedBox(height: 16),

        // Filters
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Row(
              children: [
                ElevatedButton(onPressed: () {}, child: Text('Pizza')),
                SizedBox(width: 16),
                ElevatedButton(onPressed: () {}, child: Text('Plats')),
                SizedBox(width: 16),
                ElevatedButton(onPressed: () {}, child: Text('Desert')),
                SizedBox(width: 16),
                ElevatedButton(onPressed: () {}, child: Text('Drinks')),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),

        // Menu Items Grid
        SizedBox(
          height: _tool_ * 0.485,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: 8,
              itemBuilder: (context, index) {
                return _buildMenuItemCard();
              },
            ),
          ),
        ),
      ],
    );
  }

  Column About() {
    var _tool_ = MediaQuery.of(context).size.height;
    var _ord_ = MediaQuery.of(context).size.width;
    var tool = MediaQuery.of(context).size.height /785;
    var ord = MediaQuery.of(context).size.width/360;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.location_on, size: 15, color: Color(0xaa000000)),
                SizedBox(width: 5),
                Text(
                  //"Bali, Indonesia",
                  widget.itemR.address,
                  style: TextStyle(color: Color(0xaa000000), fontSize: 15),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text("Description", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            Text('${widget.itemR.description}'),
          ],
        ),

        Column(
          children: [
            Text('thnx for vesiting , booky trgd sperpou7i'),
            Container(
              padding:  EdgeInsets.symmetric(
                vertical: _tool_ * 0.0152866242038217,
                horizontal: _ord_ * 0.0444444444444444,
              ),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 30,
                    offset: Offset(0, 20),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Instagram Icon
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              content: Text('Instagram : ${widget.itemR.ig}'),
                            ),
                      );
                      // _launchURL('https://www.instagram.com/user ');
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: Color(0xFFE3DFF5),
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                offset: Offset(5, 5),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'assets/icons/instagram.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text('Instagram', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),

                  // Facebook Icon
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              content: Text('${widget.itemR.fb}'),
                            ),
                      );
                      //_launchURL('https://www.facebook.com/hotelname ');
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: Color(0xFFE3DFF5),
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                offset: Offset(5, 5),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'assets/icons/facebook.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text('Facebook', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),

                  // Call Icon
                  InkWell(
                    borderRadius: BorderRadius.circular(50),

                    onTap: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              content: Text('${widget.itemR.numbre}'),
                            ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: Color(0xFFE3DFF5),
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                offset: Offset(5, 5),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'assets/icons/call.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text('Call', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  SingleChildScrollView Gallery() {
    var _tool_ = MediaQuery.of(context).size.height;
    var _ord_ = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: 9,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              SizedBox(
                height: _tool_ * 0.2547770700636943,
                width: _ord_ * 0.5555555555555556,
                child: Image.network(
                  widget.itemR.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.error, color: Colors.red, size: 40),
                          SizedBox(height: 8),
                          Text(
                            'Image not available',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: _tool_ * 0.0636942675159236,
                left: _ord_ * 0.0833333333333333,
                child: Text(
                  "Image ${index + 1}",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Center Reviews() {
    return Center(
      child: Text(
        "Reviews : ${widget.itemR.name}",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }

  // Menu Item Card
  Widget _buildMenuItemCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              widget.itemR.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.error, color: Colors.red, size: 40),
                      SizedBox(height: 8),
                      Text(
                        'Image not available',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber),
                    SizedBox(width: 4),
                    Text('4.9'),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  'Pizza Margherita',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
