import 'package:flutter/material.dart';
import 'package:my_app/data/hotels.dart';
import 'package:my_app/screens/hotels/confirmationbooking_screen.dart';
import 'package:my_app/widgets/contents/hotels/booking_form.dart';

class HoteldetailScreen extends StatefulWidget {
  HotelsItems item;
  HoteldetailScreen(this.item, {super.key});

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
                      height: 350,
                      color: Colors.grey[200],
                      child: Hero(
                        tag: widget.item.image,
                        child: Image.asset(widget.item.image),
                      ),
                    ),
                    Container(height: 50, color: Colors.grey[200]),
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
                                widget.item.name,
                                style: const TextStyle(
                                  fontSize: 19,
                                  color: Color(0xff180226),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${widget.item.price}*",
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
                                width: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: InkWell(
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 10),
                                      Text(
                                        widget.item.rate,
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
                            widget.item.description,
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
              top: 10,
              bottom: 10,
            ),
            height: 70,
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
    );*/
    return Scaffold(
      backgroundColor: Color(0xFFE3DFF5),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        backgroundColor: Color(0xFFE3DFF5),
        title: Text(
          widget.item.name,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Padding(
            padding: EdgeInsets.all(5),
            child: Icon(Icons.arrow_back_ios, color: Colors.black),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              widget.item.image,

              fit: BoxFit.cover,
              height: 290,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.item.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ), // Add some space between the title and the button
                      InkWell(
                        onTap: () {
                          //  Add your button's functionality here
                          //  For example, you can show a dialog:
                          showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  title: const Text('Welcome!'),
                                  content: const Text(
                                    'Thank you for visiting AYANA Resort.',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed:
                                          () => Navigator.of(context).pop(),
                                      child: const Text('Close'),
                                    ),
                                  ],
                                ),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                            color: Color(0xff402662),
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            "assets/images/icon_flech.png",
                            height: 40,
                            width: 40,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                    ],

                    // children: [
                    //   Text(
                    //     widget.item.name,
                    //     style: Theme.of(context).textTheme.titleLarge,
                    //   ),

                    // ],
                  ),
                  Row(
                    children: [
                      _buildBadge(
                        widget.item.sold,
                        background: Color(0xFF5D4CFF),
                      ),
                      SizedBox(width: 15),
                      _buildBadge(
                        widget.item.rate,
                        background: Color(0xFF403571),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 15,
                        color: Color(0xaa000000),
                      ),
                      SizedBox(width: 5),
                      Text(
                        //"Bali, Indonesia",
                        widget.item.localisation,
                        style: TextStyle(
                          color: Color(0xaa000000),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(widget.item.description),
                  const SizedBox(height: 16),
                  // Text("Price", style: Theme.of(context).textTheme.titleMedium),
                  // Text('\${widget.item.price.} USD / night'),
                ],
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
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
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBookingModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Make it full-screen if needed
      backgroundColor: Color(0xff000000),
      shape: const RoundedRectangleBorder(
        // Add rounded corners to the sheet
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
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
}

Widget _buildBadge(String text, {required Color background}) {
  return Container(
    height: 30,
    width: 65,
    alignment: Alignment(0, 0),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white, fontSize: 10),
    ),
  );
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
