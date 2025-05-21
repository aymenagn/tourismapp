import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:my_app/screens/mainHomeScreen.dart';
import 'package:my_app/screens/signup_screen.dart';
//import 'package:ui_5_travel_bag_app/rate_us.dart';

// import 'best_deals.dart';
// import 'mainpage.dart';
// import 'notifications.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    var _tool_ = MediaQuery.of(context).size.height;
    //this zoomDrawer widget if from zoomdrawer package
    return SafeArea(
      child: ZoomDrawer(
        menuScreen: Drawer(
          currentIndex: currentindex,
          setIndex: (index) {
            setState(() {
              currentindex = index;
            });
          },
        ),
        mainScreen: setScreen(),
        borderRadius: 30,
        showShadow: true,
        angle: 0,
        menuBackgroundColor: const Color(0xff402662),
        moveMenuScreen: false,
      ),
    );
  }

  Widget setScreen() {
    switch (currentindex) {
      case 0:
        return Mainhomescreen();

      case 1:
        return SignupScreen();
      case 2:
        return SafeArea(child: Scaffold(body: Center(child: Text("Screen2"))));
      case 3:
        return SafeArea(child: Scaffold(body: Center(child: Text("Screen3"))));
      case 4:
        return SafeArea(child: Scaffold(body: Center(child: Text("Screen4"))));
      case 5:
        return SafeArea(child: Scaffold(body: Center(child: Text("Screen5"))));
      default:
        return SafeArea(child: Scaffold(body: Center(child: Text("Screen6"))));
    }
  }
}

class Drawer extends StatelessWidget {
  final ValueSetter setIndex;
  final int currentIndex;
  const Drawer({super.key, required this.setIndex, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    var _tool_ = MediaQuery.of(context).size.height;
    var _ord_ = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xff402662),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: _tool_ * 0.089171974522293,
                width: _ord_ * 0.1944444444444444,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/profile.jpeg"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
               Padding(
                padding: EdgeInsets.only(top: _tool_ * 0.0254777070063694),
                child: Text(
                  "Welcome Dev73arner!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              drawerList(Icons.home_outlined, "Home Page", 0, context),
              drawerList(Icons.handshake_outlined, "Best Deal", 1, context),
              drawerList(
                Icons.notifications_outlined,
                "Notifications",
                2,
                context,
              ),
              drawerList(Icons.star_outline, "Rate Us", 3, context),
              drawerList(
                Icons.error_outline_rounded,
                "Help Center",
                4,
                context,
              ),
              drawerList(Icons.logout_outlined, "Sign Out", 5, context),
              //Expanded(child: Container())
            ],
          ),
        ),
      ),
    );
  }

  Widget drawerList(IconData icon, String text, int index, context) {
    var _tool_ = MediaQuery.of(context).size.height;
    var _ord_ = MediaQuery.of(context).size.width;
    var tool = MediaQuery.of(context).size.height /785;
    var ord = MediaQuery.of(context).size.width/360;
    return GestureDetector(
      onTap: () {
        setIndex(index);
        ZoomDrawer.of(context)!.close();
      },
      child: Container(
        padding:  EdgeInsets.only(
          bottom: 20,
          top: _tool_ * 0.0254777070063694,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: currentIndex == index ? Colors.white : Colors.white70,
            ),
            const SizedBox(width: 20),
            Text(
              text,
              style: TextStyle(
                color: currentIndex == index ? Colors.white : Colors.white70,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
