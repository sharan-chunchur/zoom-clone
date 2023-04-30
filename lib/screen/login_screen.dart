import 'package:flutter/material.dart';
import 'package:zoom_clone/screen/home_screen.dart';
import 'package:zoom_clone/widgets/auth_button.dart';

import '../resources/auth_methods.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'LoginScreen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = AuthMethods();
  var _isLoading = false;

  void googleAuth() async {
    setState(() {
      _isLoading = true;
    });
    await _auth.signInWithGoogle(context);
    // if (result && context.mounted) {
    //   Navigator.pushNamed(context, HomeScreen.routeName);
    // }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Start or Join a metting',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: Image.asset('assets/imgs/onBoarding.jpg'),
            ),
            AuthButton(
              text: 'Google Sign-In',
              onPressed: _isLoading ? (){} : googleAuth,
            )
          ],
        ),
        if(_isLoading) const Center(child: CircularProgressIndicator(),)
      ],
    ));
  }
}
