import 'package:flutter/material.dart';
import 'package:my_app/screens/login_screen.dart';

class SignUpContent extends StatelessWidget {
  const SignUpContent({super.key});

  @override
  Widget build(BuildContext context) {
    var _tool_ = MediaQuery.of(context).size.height;
    var _ord_ = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Sign up with one of the following option',
          style: TextStyle(color: Colors.black87),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.abc, size: 40.0, color: Color(0xFF000000)),
              onPressed: () {
                // Handle Google sign-in
              },
            ),
            IconButton(
              icon: const Icon(Icons.apple, size: 40.0, color: Colors.black),
              onPressed: () {
                // Handle Apple sign-in
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: _tool_ * 0.0598726114649682,
          width: _ord_ * 0.825,
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Name',
              filled: true,
              fillColor: Color(0xff1e1e1e),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: const Color(0xFFA7C2AD), // 👈 your custom color
                  width: 9, // optional: border thickness
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(
                  color: const Color(
                    0xff40354C,
                  ), // 👈 color when the field is focused
                  width: 2,
                ),
              ),
            ),
            style: TextStyle(color: Color(0xffFFFFFF), fontSize: 14),
          ),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('-', style: TextStyle(color: Color(0xDD640000))),
          ],
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: _tool_ * 0.0598726114649682,
          width: _ord_ * 0.825,
          child: TextField(
            decoration: InputDecoration(
              labelText: 'E-mail',
              filled: true,
              fillColor: Color(0xff1e1e1e),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: const Color(0xFFA7C2AD), // 👈 your custom color
                  width: 9, // optional: border thickness
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(
                  color: const Color(
                    0xff40354C,
                  ), // 👈 color when the field is focused
                  width: 2,
                ),
              ),
            ),
            style: TextStyle(color: Color(0xffFFFFFF), fontSize: 14),
          ),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('-', style: TextStyle(color: Color(0xDD640000))),
          ],
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: _tool_ * 0.0598726114649682,
          width: _ord_ * 0.825,
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              filled: true,
              fillColor: Color(0xff1e1e1e),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: const Color(0xFFA7C2AD), // 👈 your custom color
                  width: 9, // optional: border thickness
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(
                  color: const Color(
                    0xff40354C,
                  ), // 👈 color when the field is focused
                  width: 2,
                ),
              ),
              suffixIcon: const Icon(
                Icons.visibility_outlined,
                color: Color.fromARGB(179, 158, 23, 23),
              ),
              suffixIconConstraints: BoxConstraints(
                minWidth: _ord_ * 0.1333333333333333,
                minHeight: _tool_ * 0.0598726114649682,
              ),
            ),
            style: TextStyle(color: Color(0xFFffffff), fontSize: 14),
          ),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('-', style: TextStyle(color: Color(0xDD640000))),
          ],
        ),
        const SizedBox(height: 25),
        ElevatedButton(
          onPressed: () {
            // Handle create account logic
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF402662),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
          ),
          child: const Text(
            'Create Account',
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Already have an account? ',
              style: TextStyle(color: Colors.black87),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
                // Handle log in navigation
              },
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
