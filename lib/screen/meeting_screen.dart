import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:zoom_clone/screen/video_call_screen.dart';

import '../resources/jitsi_meet_methods.dart';
import '../widgets/home_meeting_button.dart';

class MeetingScreen extends StatelessWidget {
  MeetingScreen({Key? key}) : super(key: key);

  final JitsiMeetMethods jitsiMeetMethods = JitsiMeetMethods();

  createNewMeeting() {
    var random = Random();
    String rooomName = (random.nextInt(10000000) + 10000000).toString();
    jitsiMeetMethods.createNewMeeting(roomName: rooomName, isAudioMuted: true, isVideoMuted: true);
  }

  joinMeeting(BuildContext context) {
    Navigator.pushNamed(context, VideoCallScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              HomeMeetingButton(
                onPressed: createNewMeeting,
                icon: Icons.videocam,
                text: 'New Meeting',
              ),
              HomeMeetingButton(
                onPressed: () {
                  joinMeeting(context);
                },
                icon: Icons.add_box_rounded,
                text: 'Join Meeting',
              ),
              HomeMeetingButton(
                onPressed: () {},
                icon: Icons.calendar_today,
                text: 'Schedule',
              ),
              HomeMeetingButton(
                onPressed: () {},
                icon: Icons.arrow_upward_rounded,
                text: 'Share Screen',
              )
            ],
          ),
          const Expanded(
              child: Center(
            child: Text(
              'Create/Join meetings with just a click',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ))
        ],
      ),
    );
  }
}
