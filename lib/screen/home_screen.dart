import 'package:flutter/material.dart';
import 'package:zoom_clone/resources/auth_methods.dart';
import 'package:zoom_clone/screen/history_meeting_screen.dart';
import 'package:zoom_clone/screen/meeting_screen.dart';
import 'package:zoom_clone/utils/colors.dart';
import 'package:zoom_clone/widgets/auth_button.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pageNum = 0;

  List<Widget> pages =[
    MeetingScreen(),
    HistroyMeetingScreen(),
    const Text('contacts'),
    AuthButton(text: 'Log out', onPressed: () {
      AuthMethods().signOut();
    } ),
  ];


  void onPageChanged(int pageNum) {
    setState(() {
      _pageNum = pageNum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meet and Chat'),
        elevation: 0,
        backgroundColor: backgroundColor,
        centerTitle: true,
      ),
      body: pages[_pageNum],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: footerColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: onPageChanged,
        currentIndex: _pageNum,
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 14,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.comment_bank), label: 'Meet & Chat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.lock_clock), label: 'meetings'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Contacts'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}


