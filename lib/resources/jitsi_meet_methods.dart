
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:zoom_clone/resources/auth_methods.dart';
import 'package:zoom_clone/resources/firestore_methods.dart';

class JitsiMeetMethods {
  final  AuthMethods _authMethods =  AuthMethods();
final FirestoreMethods firestoreMethods = FirestoreMethods();

 void createNewMeeting({required String roomName, required bool isAudioMuted, required bool isVideoMuted, String name=''}) async {
   try {
     String userName;
     if(name.isEmpty){
       //if user created meeting then username will be assigned from authmethods
       userName = _authMethods.user.displayName!;
     }else{
       //if user joined meeting then username will be passed from argument
       userName = name;
     }

     final roomText = roomName;
     const subjectText = "Zoom Test Meeting";
     final userDisplayNameText = userName;
     final userEmailText = _authMethods.user.email;
     final userAvatarUrlText = _authMethods.user.photoURL;
     bool isAudioOnly = false;

     // Define meetings options here
     var options = JitsiMeetingOptions(
       roomNameOrUrl: roomText,
       subject: subjectText,
       isAudioMuted: isAudioMuted,
       isAudioOnly: isAudioOnly,
       isVideoMuted: isVideoMuted,
       userDisplayName: userDisplayNameText,
       userEmail: userEmailText,
       userAvatarUrl: userAvatarUrlText
     );

     //adding meeting details to firestore
     firestoreMethods.addToMettingHistory(roomName);

     //creating meeting
     await JitsiMeetWrapper.joinMeeting(
       options: options,
       listener: JitsiMeetingListener(
         onConferenceWillJoin: (url) => print("onConferenceWillJoin: url: $url"),
         onConferenceJoined: (url) => print("onConferenceJoined: url: $url"),
         onConferenceTerminated: (url, error) => print("onConferenceTerminated: url: $url, error: $error"),
       ),
     );
   }catch (e){
     print(e);
   }
 }
}