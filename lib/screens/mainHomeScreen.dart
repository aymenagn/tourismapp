import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:my_app/screens/home_screen.dart';

class Mainhomescreen extends StatefulWidget {
  const Mainhomescreen({super.key});

  @override
  State<Mainhomescreen> createState() => _MainhomescreenState();
}

class _MainhomescreenState extends State<Mainhomescreen> {
  int _selectedIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = List.generate(
    4,
    (index) => GlobalKey<NavigatorState>(),
  );

  void _onTabSelected(int index) {
    if (_selectedIndex == index) {
      // Pops to first route if re-selecting the same tab
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Widget _buildOffstageNavigator(int index, Widget screen) {
    return Offstage(
      offstage: _selectedIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (settings) {
          return MaterialPageRoute(builder: (context) => screen);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_selectedIndex].currentState!.maybePop();

        if (isFirstRouteInCurrentTab) {
          if (_selectedIndex != 0) {
            setState(() {
              _selectedIndex = 0;
            });
            return false; // Prevent exiting the app
          }
          return true; // Exit the app
        }

        return false; // Don't exit, just pop the route
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              _buildOffstageNavigator(0, const HomeScreen()),
              _buildOffstageNavigator(
                1,
                const Center(child: Text("Search Screen")),
              ),
              _buildOffstageNavigator(
                2,
                const Center(child: Text("Likes Screen")),
              ),
              _buildOffstageNavigator(
                3,
                const Center(child: Text("Profile Screen")),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            color: const Color(0xff40354C),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: GNav(
                gap: 8,
                tabBackgroundColor: const Color(0xffE3DFF5),
                color: const Color(0xffE3DFF5),
                activeColor: const Color(0xff40354C),
                backgroundColor: const Color(0xff40354C),
                padding: const EdgeInsets.all(10),
                selectedIndex: _selectedIndex,
                onTabChange: _onTabSelected,
                tabs: const [
                  GButton(icon: Icons.home_outlined, text: "Home"),
                  GButton(icon: Icons.search_outlined, text: "Search"),
                  GButton(icon: Icons.favorite_outline, text: "Favorite"),
                  GButton(icon: Icons.person_2_outlined, text: "Profile"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
