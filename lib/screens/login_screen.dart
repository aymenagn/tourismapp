import 'package:flutter/material.dart';
import 'package:my_app/widgets/contents/loginContent.dart';
import 'package:my_app/widgets/mainwidget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff40354C),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // double screenWidth = constraints.maxWidth;
          // double screenHeight = constraints.maxHeight;
          // return MainWidget(title: 'title', content: Text('data'));
          return MainWidget(
            icontop: Icons.menu,
            title: 'Log In',
            content: loginContent(),
            pad: true,
            contHeigt: 590,
            sizedboxHeigt: 100,
          );
        },
      ),
    );
  }
}
