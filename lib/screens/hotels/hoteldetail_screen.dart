import 'package:flutter/material.dart';
import 'package:my_app/data/hotels.dart';
import 'package:my_app/widgets/contents/hotels/booking_form.dart';

class HoteldetailScreen extends StatefulWidget {
  HotelsItems itemH;
  HoteldetailScreen(this.itemH, {super.key});

  @override
  State<HoteldetailScreen> createState() => _HoteldetailScreenState();
}

class _HoteldetailScreenState extends State<HoteldetailScreen>
    with SingleTickerProviderStateMixin {
  bool isfav = false;
  late AnimationController _animationController;
  //this is used for animation
  late Animation<Color?> _coloranimation;
  late Animation<double> _sizeAnimation;
  @override
  // Future<void> _launchURL(String url) async {
  //   final Uri uri = Uri.parse(url);
  //   try {
  //     if (await canLaunchUrl(uri)) {
  //       await launchUrl(uri);
  //     } else {
  //       _showErrorDialog(context, 'Could not launch $url');
  //     }
  //   } catch (e) {
  //     _showErrorDialog(context, 'Error launching URL: $e');
  //   }
  // }
  // void _launchCall(String number) async {
  //   try {
  //     // Check if permission is granted
  //     var status = await Permission.phone.status;
  //     if (!status.isGranted) {
  //       status = await Permission.phone.request();
  //       if (!status.isGranted) {
  //         _showErrorDialog(context, "Phone permission denied.");
  //         return;
  //       }
  //     }
  //     final Uri launchUri = Uri(scheme: 'tel', path: number);
  //     if (await canLaunchUrl(launchUri)) {
  //       await launchUrl(launchUri);
  //     } else {
  //       _showErrorDialog(context, "Could not call $number");
  //     }
  //   } catch (e) {
  //     _showErrorDialog(context, "Error making call: $e");
  //   }
  // }
  // void _callNumber(String num) async {
  //   bool? res = await FlutterPhoneDirectCaller.callNumber(num);
  // }
  // void _showErrorDialog(BuildContext context, String message) {
  //   showDialog(
  //     context: context,
  //     builder:
  //         (context) => AlertDialog(
  //           title: Text("Error"),
  //           content: Text(message),
  //           actions: [
  //             TextButton(
  //               onPressed: Navigator.of(context).pop,
  //               child: Text("OK"),
  //             ),
  //           ],
  //         ),
  //   );
  // }
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
          '${widget.itemH.name}',
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
                            _buildHotelInfo(),

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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            end: Alignment.topCenter,
            begin: Alignment.bottomCenter,
            colors: [Color(0xff40354C), Color(0xff40354C)],
          ),
        ),
        child: BottomAppBar(
          color: Color.fromARGB(0, 64, 53, 76),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '\$350 ',
                          style: const TextStyle(
                            color: Color(0xFF00AEEF), // Light blue
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text: 'USD /',
                          style: TextStyle(
                            color: Color(0xFF00AEEF),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'night',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  _showBookingModal(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(
                    0xFF4B297A,
                  ), // Button color (deep purple)
                  padding:  EdgeInsets.symmetric(
                    horizontal: _ord_ * 0.0666666666666667,
                    vertical: _tool_ * 0.0152866242038217,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'BOOK NOW',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ],
          ),
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
          child: Image.asset(
            '${widget.itemH.image}',
            // width: MediaQuery.of(context).size.width * 0.75,
            width: _ord_,
            height: _tool_ * 0.3185,
            fit: BoxFit.cover,
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
                      child: Image.asset(
                        '${widget.itemH.image}',
                        width: _ord_ * 0.1944444444444444,
                        height: _tool_ * 0.089171974522293,
                        fit: BoxFit.cover,
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
  Widget _buildHotelInfo() {
    var _tool_ = MediaQuery.of(context).size.height;
    var _ord_ = MediaQuery.of(context).size.width;
    var tool = MediaQuery.of(context).size.height /785;
    var ord = MediaQuery.of(context).size.width/360;
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Offer
          // Row(
          //   children: [
          //     Icon(Icons.local_offer, color: Colors.green),
          //     SizedBox(width: 4),
          //     Text(
          //       '${widget.itemH.rating}',
          //       style: TextStyle(color: Colors.green),
          //     ),
          //   ],
          // ),
          // SizedBox(height: 8),

          // Restaurant Name
          Text(
            '${widget.itemH.name}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              _buildBadge(
                '${widget.itemH.sold}',
                background: Color(0xFF5D4CFF),
              ),
              SizedBox(width: 15),
              _buildBadge(
                "${widget.itemH.rating}",
                background: Color(0xFF403571),
                showIcon: true,
              ),
            ],
          ),
          SizedBox(height: 16),

          // localisation
          Row(
            children: [
              Icon(Icons.location_on, size: 16),
              SizedBox(width: 4),
              Text('${widget.itemH.localisation}'),
            ],
          ),
        ],
      ),
    );
  }

  // Tabs
  Widget _buildTabs() {
    var _tool_ = MediaQuery.of(context).size.height;
    var _ord_ = MediaQuery.of(context).size.width;
    var tool = MediaQuery.of(context).size.height /785;
    var ord = MediaQuery.of(context).size.width/360;
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            indicatorColor: Color(0xFF4A235A),
            labelColor: Color(0xFF4A235A),
            unselectedLabelColor: Colors.grey,
            tabs: [
              // Tab(text: 'Menu'),
              Tab(text: 'About'),
              Tab(text: 'Gallery'),
              Tab(text: 'Reviews'),
            ],
          ),
          SizedBox(
            height:
                _tool_ /
                2.1000000000001, // Adjust as needed
            child: TabBarView(
              children: [
                // _buildContent(build_: Menu()),
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
          height: _tool_/ 2.075834935555555555,
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
          children: [
            Row(
              children: [
                Icon(Icons.location_on, size: 15, color: Color(0xaa000000)),
                SizedBox(width: 5),
                Text(
                  //"Bali, Indonesia",
                  '${widget.itemH.localisation}',
                  style: TextStyle(color: Color(0xaa000000), fontSize: 15),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text("Description", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            Text('${widget.itemH.description}'),
          ],
        ),

        Column(
          children: [
            Text('thnx for vesiting , booky trgd sperpou7i'),
            Container(
              padding: EdgeInsets.symmetric(
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
                              content: Text('Instagram : ${widget.itemH.ig}'),
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
                              content: Text('${widget.itemH.fb}'),
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
                              content: Text('${widget.itemH.numbre}'),
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
    var tool = MediaQuery.of(context).size.height /785;
    var ord = MediaQuery.of(context).size.width/360;
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
                child: Image.asset('${widget.itemH.image}', fit: BoxFit.cover),
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
        "Reviews : ${widget.itemH.name}",
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
    var _tool_ = MediaQuery.of(context).size.height;
    var _ord_ = MediaQuery.of(context).size.width;
    var tool = MediaQuery.of(context).size.height /785;
    var ord = MediaQuery.of(context).size.width/360;
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Column(
        children: [
          Expanded(
            child: Image.asset('${widget.itemH.image}', fit: BoxFit.cover),
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

  void _showBookingModal(BuildContext context) {
    var _tool_ = MediaQuery.of(context).size.height;
    var _ord_ = MediaQuery.of(context).size.width;
    var tool = MediaQuery.of(context).size.height /785;
    var ord = MediaQuery.of(context).size.width/360;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Make it full-screen if needed
      backgroundColor: Color.fromARGB(0, 0, 0, 0),
      shape: const RoundedRectangleBorder(
        // Add rounded corners to the sheet
        borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
      ),
      builder: (context) {
        // Use Padding to adjust content when the keyboard appears
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xffE3DFF5), Color(0xff40354C)],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            ),
            child: const BookingForm(),
          ), // Use the extracted widget here
        );
      },
    );
  }


Widget _buildBadge(
  String text, {
  required Color background,
  bool showIcon = false,
}) {
    var _tool_ = MediaQuery.of(context).size.height;
    var _ord_ = MediaQuery.of(context).size.width;
    var tool = MediaQuery.of(context).size.height /785;
    var ord = MediaQuery.of(context).size.width/360;
  return Container(
    height: 30,
    width: _ord_ * 0.1805555555555556,
    alignment: Alignment(0, 0),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(20),
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
void _showBookingModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize:
              MainAxisSize.min, // Important for the modal to fit content
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Date Selection
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'From',
                        style: TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '24',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 4.0),
                          Text('Mon', style: TextStyle(fontSize: 14.0)),
                          SizedBox(width: 2.0),
                          Text('Oct', style: TextStyle(fontSize: 14.0)),
                        ],
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_forward_rounded, color: Colors.grey),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'To',
                        style: TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '26',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 4.0),
                          Text('Wed', style: TextStyle(fontSize: 14.0)),
                          SizedBox(width: 2.0),
                          Text('Oct', style: TextStyle(fontSize: 14.0)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            // Adults
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('2 Adults (+18yrs)', style: TextStyle(fontSize: 16.0)),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        /* Handle decrement */
                      },
                    ),
                    Text('2', style: TextStyle(fontSize: 16.0)),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        /* Handle increment */
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8.0),

            // Children
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('1 Children (-18yrs)', style: TextStyle(fontSize: 16.0)),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        /* Handle decrement */
                      },
                    ),
                    Text('1', style: TextStyle(fontSize: 16.0)),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        /* Handle increment */
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8.0),

            // Rooms
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('1 Rooms', style: TextStyle(fontSize: 16.0)),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        /* Handle decrement */
                      },
                    ),
                    Text('1', style: TextStyle(fontSize: 16.0)),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        /* Handle increment */
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24.0),

            // Optional: A button to apply the selection
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the bottom sheet
                  // Handle the selected booking options
                  print('Selected options: ...');
                },
                child: Text('Apply'),
              ),
            ),
          ],
        ),
      );
    },
  );
}

  /*return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: _tool_ *0.445859872611465,
                      color: Colors.grey[200],
                      child: Hero(
                        tag: widget.itemH.image,
                        child: Image.asset(widget.itemH.image),
                      ),
                    ),
                    Container(height: _tool_ *0.0636942675159236, color: Colors.grey[200]),
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      color: Colors.white54,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.itemH.name,
                                style: const TextStyle(
                                  fontSize: 19,
                                  color: Color(0xff180226),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${widget.itemH.price}*",
                                style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(2),
                                width: _ord_  * 0.1944444444444444,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: InkWell(
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 10),
                                      Text(
                                        widget.itemH.rating,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                "125+ Review",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            widget.itemH.description,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(color: Colors.white),
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: _tool_ *0.0127388535031847,
              bottom: 10,
            ),
            height: _tool_ *0.089171974522293,
            child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xff06c1cf),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "BUY NOW ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
//     );*/
  //     return Scaffold(
  //       backgroundColor: Color(0xFFE3DFF5),
  //       appBar: AppBar(
  //         surfaceTintColor: Colors.transparent,
  //         elevation: 0,
  //         backgroundColor: Color(0xFFE3DFF5),
  //         title: Text(
  //           '${widget.itemH.name}',
  //           style: const TextStyle(
  //             color: Colors.black,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         leading: IconButton(
  //           icon: const Padding(
  //             padding: EdgeInsets.all(5),
  //             child: Icon(Icons.arrow_back_ios, color: Colors.black),
  //           ),
  //           onPressed: () {
  //             Navigator.pop(context);
  //           },
  //         ),
  //         actions: [
  //           IconButton(
  //             icon: const Icon(Icons.share, color: Colors.black),
  //             onPressed: () {
  //               // Handle share action
  //               /*Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder:
  //                       (context) => ConfirmationbookingScreen( // Use the new screen here
  //                         bookingDate: bookingDate,
  //                         checkInDate: checkInDate,
  //                         checkOutDate: checkOutDate,
  //                         adults: _adults,
  //                         children: _children,
  //                         rooms: _rooms,
  //                         totalPrice: _totalPrice,
  //                         ),
  //                 ),
  //               );*/
  //             },
  //           ),
  //           AnimatedBuilder(
  //             animation: _animationController,
  //             builder: (BuildContext context, _) {
  //               return IconButton(
  //                 icon: Icon(
  //                   Icons.favorite,
  //                   color: _coloranimation.value,
  //                   size: _sizeAnimation.value,
  //                 ),
  //                 onPressed: () {
  //                   isfav
  //                       ? _animationController.reverse()
  //                       : _animationController.forward();
  //                 },
  //               );
  //             },
  //           ),
  //         ],
  //       ),
  //       body: SingleChildScrollView(
  //         child: Column(
  //           children: [
  //             Image.asset(
  //               '${widget.itemH.image}',

  //               fit: BoxFit.cover,
  //               height: 290,
  //               width: double.infinity,
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(16.0),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Padding(
  //                     padding: EdgeInsets.only(top: 10, bottom: 20),
  //                     child: Text(
  //                       '${widget.itemH.name}',
  //                       style: TextStyle(
  //                         fontSize: 20,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),

  //                     // children: [
  //                     //   Text(
  //                     //     widget.itemH.name,
  //                     //     style: Theme.of(context).textTheme.titleLarge,
  //                     //   ),

  //                     // ],
  //                   ),
  //                   Row(
  //                     children: [
  //                       _buildBadge(
  //                         '${widget.itemH.sold}',
  //                         background: Color(0xFF5D4CFF),
  //                       ),
  //                       SizedBox(width: 15),
  //                       _buildBadge(
  //                         "${widget.itemH.rating}",
  //                         background: Color(0xFF403571),
  //                         showIcon: true,
  //                       ),
  //                     ],
  //                   ),
  //                   SizedBox(height: 10),
  //                   Row(
  //                     children: [
  //                       Icon(
  //                         Icons.location_on,
  //                         size: 15,
  //                         color: Color(0xaa000000),
  //                       ),
  //                       SizedBox(width: 5),
  //                       Text(
  //                         //"Bali, Indonesia",
  //                         '${widget.itemH.localisation}',
  //                         style: TextStyle(
  //                           color: Color(0xaa000000),
  //                           fontSize: 15,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   const SizedBox(height: 16),
  //                   Text(
  //                     "Description",
  //                     style: Theme.of(context).textTheme.titleMedium,
  //                   ),
  //                   Text('${widget.itemH.description}'),
  //                   const SizedBox(height: 16),
  //                   // Text("Price", style: Theme.of(context).textTheme.titleMedium),
  //                   // Text('\${widget.itemH.price.} USD / night'),
  //                 ],
  //               ),
  //             ),

  //             // ElevatedButton(
  //             //   onPressed: () {
  //             //     // _launchURL("https://google.com ");
  //             //   },
  //             //   child: Text("Open Google"),
  //             // ),
  //             SizedBox(height: 10),
  //             Text('thnx for vesiting , booky trgd sperpou7i'),
  //             const SizedBox(height: 20),
  //             Container(
  //               padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
  //               decoration: BoxDecoration(
  //                 color: Colors.transparent,
  //                 borderRadius: BorderRadius.circular(12),
  //                 boxShadow: [
  //                   BoxShadow(
  //                     color: Colors.black12,
  //                     blurRadius: 30,
  //                     offset: Offset(0, 20),
  //                   ),
  //                 ],
  //               ),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 children: [
  //                   // Instagram Icon
  //                   InkWell(
  //                     borderRadius: BorderRadius.circular(50),
  //                     onTap: () {
  //                       showDialog(
  //                         context: context,
  //                         builder:
  //                             (context) => AlertDialog(
  //                               content: Text('Instagram : ${widget.itemH.ig}'),
  //                             ),
  //                       );
  //                       // Handle Instagram link or open URL
  //                       // _launchURL('https://www.instagram.com/ur_.aymen ');
  //                     },
  //                     child: Column(
  //                       children: [
  //                         Container(
  //                           height: 35,
  //                           width: 35,
  //                           decoration: BoxDecoration(
  //                             color: Color(0xFFE3DFF5),
  //                             borderRadius: BorderRadius.circular(50),
  //                             boxShadow: [
  //                               BoxShadow(
  //                                 color: Colors.black12,
  //                                 blurRadius: 5,
  //                                 offset: Offset(5, 5),
  //                               ),
  //                             ],
  //                           ),
  //                           child: Image.asset(
  //                             'assets/icons/instagram.png',
  //                             fit: BoxFit.cover,
  //                           ),
  //                         ),
  //                         SizedBox(height: 4),
  //                         Text('Instagram', style: TextStyle(fontSize: 12)),
  //                       ],
  //                     ),
  //                   ),

  //                   // Facebook Icon
  //                   InkWell(
  //                     borderRadius: BorderRadius.circular(50),
  //                     onTap: () {
  //                       showDialog(
  //                         context: context,
  //                         builder:
  //                             (context) =>
  //                                 AlertDialog(content: Text('${widget.itemH.fb}')),
  //                       );
  //                       // Handle Facebook link or open URL
  //                       //_launchURL('https://www.facebook.com/hotelname ');
  //                     },
  //                     child: Column(
  //                       children: [
  //                         Container(
  //                           height: 35,
  //                           width: 35,
  //                           decoration: BoxDecoration(
  //                             color: Color(0xFFE3DFF5),
  //                             borderRadius: BorderRadius.circular(50),
  //                             boxShadow: [
  //                               BoxShadow(
  //                                 color: Colors.black12,
  //                                 blurRadius: 5,
  //                                 offset: Offset(5, 5),
  //                               ),
  //                             ],
  //                           ),
  //                           child: Image.asset(
  //                             'assets/icons/facebook.png',
  //                             fit: BoxFit.cover,
  //                           ),
  //                         ),
  //                         SizedBox(height: 4),
  //                         Text('Facebook', style: TextStyle(fontSize: 12)),
  //                       ],
  //                     ),
  //                   ),

  //                   // Call Icon
  //                   InkWell(
  //                     borderRadius: BorderRadius.circular(50),

  //                     onTap: () {
  //                       // Handle phone call
  //                       // FlutterPhoneDirectCaller.callNumber('+12345678');

  //                       // FlutterDirectCallerPlugin.callNumber('+12345678');
  //                       // _callNumber('1234567');
  //                       // _launchCall('+12345678');

  //                       // _launchCall('${widget.itemH.numbre}');
  //                       showDialog(
  //                         context: context,
  //                         builder:
  //                             (context) => AlertDialog(
  //                               content: Text('${widget.itemH.numbre}'),
  //                             ),
  //                       );
  //                     },
  //                     child: Column(
  //                       children: [
  //                         Container(
  //                           height: 35,
  //                           width: 35,
  //                           decoration: BoxDecoration(
  //                             color: Color(0xFFE3DFF5),
  //                             borderRadius: BorderRadius.circular(50),
  //                             boxShadow: [
  //                               BoxShadow(
  //                                 color: Colors.black12,
  //                                 blurRadius: 5,
  //                                 offset: Offset(5, 5),
  //                               ),
  //                             ],
  //                           ),
  //                           child: Image.asset(
  //                             'assets/icons/call.png',
  //                             fit: BoxFit.cover,
  //                           ),
  //                         ),
  //                         SizedBox(height: 4),
  //                         Text('Call', style: TextStyle(fontSize: 12)),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       bottomNavigationBar: Container(
  //         decoration: BoxDecoration(
  //           gradient: LinearGradient(
  //             end: Alignment.topCenter,
  //             begin: Alignment.bottomCenter,
  //             colors: [Color(0xff40354C), Color(0xff40354C)],
  //           ),
  //         ),
  //         child: BottomAppBar(
  //           color: Color.fromARGB(0, 64, 53, 76),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   RichText(
  //                     text: TextSpan(
  //                       children: [
  //                         TextSpan(
  //                           text: '\$350 ',
  //                           style: const TextStyle(
  //                             color: Color(0xFF00AEEF), // Light blue
  //                             fontSize: 18,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                         const TextSpan(
  //                           text: 'USD /',
  //                           style: TextStyle(
  //                             color: Color(0xFF00AEEF),
  //                             fontSize: 14,
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   const SizedBox(height: 4),
  //                   const Text(
  //                     'night',
  //                     style: TextStyle(color: Colors.white70, fontSize: 14),
  //                   ),
  //                 ],
  //               ),
  //               ElevatedButton(
  //                 onPressed: () {
  //                   _showBookingModal(context);
  //                 },
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: Color(
  //                     0xFF4B297A,
  //                   ), // Button color (deep purple)
  //                   padding: const EdgeInsets.symmetric(
  //                     horizontal: 24,
  //                     vertical: 12,
  //                   ),
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(12),
  //                   ),
  //                 ),
  //                 child: const Text(
  //                   'BOOK NOW',
  //                   style: TextStyle(
  //                     color: Colors.white,
  //                     fontWeight: FontWeight.bold,
  //                     letterSpacing: 1,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
  //   }
