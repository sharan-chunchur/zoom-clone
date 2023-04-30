import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zoom_clone/resources/auth_methods.dart';
import 'package:zoom_clone/screen/home_screen.dart';
import 'package:zoom_clone/screen/login_screen.dart';
import 'package:zoom_clone/screen/video_call_screen.dart';
import 'package:zoom_clone/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zoom Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: StreamBuilder(
        stream: AuthMethods().authChanges,
        builder: (context, snapshot){
          if( snapshot.connectionState== ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.hasData){
            return const HomeScreen();
          }
          return LoginScreen();
        },
      ),
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        VideoCallScreen.routeName : (context) => VideoCallScreen(),
      },
    );
  }
}
