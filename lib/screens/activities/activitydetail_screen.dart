import 'package:flutter/material.dart';
import 'package:my_app/data/activities.dart';

class ActivitydetailScreen extends StatefulWidget {
  Activity itemA;
  ActivitydetailScreen(this.itemA, {super.key});

  @override
  State<ActivitydetailScreen> createState() => _ActivitydetailScreenState();
}

class _ActivitydetailScreenState extends State<ActivitydetailScreen>
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

  Widget buildListViewContainer(Widget child) {
    var _tool_ = MediaQuery.of(context).size.height;
    var _ord_ = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      height: _tool_ * 0.3847133757961783,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: child,
    );
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
          '${widget.itemA.title}',
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
                        height: _tool_ * 0.815,
                        decoration: BoxDecoration(
                          color: Color(0xFFE8DEF8),
                          // Background color
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30),
                          ), // Rounded corners
                        ),

                        child: Column(
                          children: [
                            _buildActivityInfo(),

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
    final limitedImages = widget.itemA.images!.take(3).toList();
    var _tool_ = MediaQuery.of(context).size.height;
    var _ord_ = MediaQuery.of(context).size.width;
    var tool = MediaQuery.of(context).size.height /785;
    var ord = MediaQuery.of(context).size.width/360;
    return Stack(
      children: [
        // Banner Image
        SizedBox(
          child: Image.network(
            '${widget.itemA.imageUrl}',
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
              itemCount: limitedImages.length,
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
                        widget.itemA.images![index],
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
  Widget _buildActivityInfo() {
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
          //       '${widget.itemA.duration}',
          //       style: TextStyle(color: Colors.green),
          //     ),
          //   ],
          // ),
          // SizedBox(height: 8),

          // Restaurant Name
          Text(
            '${widget.itemA.title}',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                  Text('${widget.itemA.activityType}'),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber),
                  SizedBox(width: 4),
                  Text('${widget.itemA.duration}'),
                ],
              ),
              SizedBox(width: 16),
            ],
          ),
          SizedBox(height: 4),

          // isForFamilies
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.location_on, size: 16),
              SizedBox(width: 4),
              Text('${widget.itemA.isForFamilies}'),
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
      length: 4,
      child: Column(
        children: [
          TabBar(
            indicatorColor: Color(0xFF4A235A),
            labelColor: Color(0xFF4A235A),
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'About'),
              Tab(text: 'Program'),
              Tab(text: 'Info'),
              Tab(text: 'Gallery'),
            ],
          ),
          SizedBox(
            height: _tool_ * 0.603,
            child: TabBarView(
              children: [
                _buildContent(build_: About()),
                _buildContent(build_: Program()),
                _buildContent(build_: Info()),
                _buildContent(build_: Gallery()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Info Content
  Widget _buildContent({required Widget build_}) {
    var _tool_ = MediaQuery.of(context).size.height;
    var _ord_ = MediaQuery.of(context).size.width;
    var tool = MediaQuery.of(context).size.height /785;
    var ord = MediaQuery.of(context).size.width/360;
    return Padding(padding: EdgeInsets.all(16), child: build_);
  }

  Column About() {
    var _tool_ = MediaQuery.of(context).size.height;
    var _ord_ = MediaQuery.of(context).size.width;
    var tool = MediaQuery.of(context).size.height /785;
    var ord = MediaQuery.of(context).size.width/360;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " The Activities : -${widget.itemA.title}-",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        SizedBox(height: 20),
        Expanded(
          // height: _tool_  * 0.562,
          child: ListView.builder(
            itemCount: widget.itemA.activities!.length,
            itemBuilder:
                (contect, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 71, 57, 77),
                        child: Text(
                          'Day${index + 1}',
                          style: TextStyle(color: Color(0xFFE3DFF5)),
                        ),
                      ),
                      title: Text(widget.itemA.activities![index]),
                    ),
                    Divider(),
                  ],
                ),
          ),
        ),
      ],
    );
  }

  Column Info() {
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
                  '${widget.itemA.isForFamilies}',
                  style: TextStyle(color: Color(0xaa000000), fontSize: 15),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text("Description", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            Text('${widget.itemA.activities}'),
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
                              content: Text(
                                'Instagram :',
                              ), // ${widget.itemA.ig}'),
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
                              content: Text('fb : '),
                            ), //${widget.itemA.fb}')),
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
                              content: Text(
                                'num : ',
                              ), //${widget.itemA.numbre}'),
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
        itemCount: widget.itemA.images!.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              SizedBox(
                height: _tool_ * 0.2547770700636943,
                width: _ord_ * 0.5555555555555556,
                child: Image.network(
                  widget.itemA.images![index],
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

  Column Program() {
    var _tool_ = MediaQuery.of(context).size.height;
    var _ord_ = MediaQuery.of(context).size.width;
    var tool = MediaQuery.of(context).size.height /785;
    var ord = MediaQuery.of(context).size.width/360;
    return Column(
      children: [
        Text(
          "Program : -${widget.itemA.title}-",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        SizedBox(height: 20),

        Expanded(
          child: ListView.builder(
            itemCount: widget.itemA.program!.length,
            itemBuilder:
                (contect, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 71, 57, 77),
                        child: Text(
                          'Day${index + 1}',
                          style: TextStyle(color: Color(0xFFE3DFF5)),
                        ),
                      ),
                      title: Text(widget.itemA.program![index]),
                    ),
                    Divider(),
                  ],
                ),
          ),
        ),
        // buildListViewContainer(),
        // SizedBox(height: 100),
      ],
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
            child: Image.network(
              '${widget.itemA.imageUrl}',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.error,
                        color: Color.fromARGB(255, 64, 64, 64),
                        size: 40,
                      ),
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
