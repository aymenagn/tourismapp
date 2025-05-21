import 'package:flutter/material.dart';
import 'package:my_app/widgets/contents/signUpContent.dart';
import 'package:my_app/widgets/mainwidget.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var _tool_ = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff40354C),
        body: LayoutBuilder(
          builder: (context, constraints) {
            // double screenWidth = constraints.maxWidth;
            // double screenHeight = constraints.maxHeight;

            // double x1 = screenWidth * 0.09444; // 5% from left
            // double y1 = screenHeight * 0.05375; // 5% from top

            return MainWidget(
              // ignore: void_checks
              // icontop: Icons.menu,
              title: 'SignUp',
              content: SignUpContent(),
              pad: true,
              contHeigt: _tool_ * 0.75010001,
              sizedboxHeigt: _tool_ * 0.1376000001,
            );
          },
        ),
      ),
    );
  }
}
