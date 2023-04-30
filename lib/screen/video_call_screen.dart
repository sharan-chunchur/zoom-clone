import 'package:flutter/material.dart';
import 'package:zoom_clone/resources/auth_methods.dart';
import 'package:zoom_clone/resources/jitsi_meet_methods.dart';
import 'package:zoom_clone/widgets/auth_button.dart';
import 'package:zoom_clone/widgets/meeting_option.dart';

import '../utils/colors.dart';

class VideoCallScreen extends StatefulWidget {
  static const routeName = 'VideoCallScreen';

  const VideoCallScreen({Key? key}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final AuthMethods _authMethods = AuthMethods();
  late TextEditingController meetingIdController;
  late TextEditingController nameController;
  final JitsiMeetMethods jitsiMeetMethods = JitsiMeetMethods();

  bool isAudioMuted = true;
  bool isVideoMuted = true;

  @override
  void initState() {
    super.initState();
    meetingIdController = TextEditingController();
    nameController = TextEditingController(text: _authMethods.user.displayName);
  }

  switchAudioState(bool val){
    setState(() {
      isAudioMuted = val;
    });
  }

  switchVideoState(bool val){
    setState(() {
      isVideoMuted = val;
    });
  }

  joinMeeting(){
    jitsiMeetMethods.createNewMeeting(roomName: meetingIdController.text, isAudioMuted: isAudioMuted, isVideoMuted: isVideoMuted, name: nameController.text);
  }

  @override
  void dispose() {
    nameController.dispose();
    meetingIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join a meeting'),
        elevation: 0,
        backgroundColor: backgroundColor,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: TextField(
                  controller: meetingIdController,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    fillColor: secondaryBackgroundColor,
                    filled: true,
                    border: InputBorder.none,
                    hintText: 'Enter Room Id',
                    // contentPadding: EdgeInsets.fromLTRB(24, 8, 0, 0)
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: TextField(
                  controller: nameController,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    fillColor: secondaryBackgroundColor,
                    filled: true,
                    border: InputBorder.none,
                    hintText: 'Name',
                    // contentPadding: EdgeInsets.fromLTRB(24, 8, 0, 0)
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: joinMeeting,
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('Join', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: MeetingOption(text: 'Audio', isMute: isAudioMuted, onChange: switchAudioState,),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: MeetingOption(text: 'Video', isMute: isVideoMuted, onChange: switchVideoState,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
