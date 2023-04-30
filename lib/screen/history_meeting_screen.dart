import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zoom_clone/resources/firestore_methods.dart';

class HistroyMeetingScreen extends StatelessWidget {
  const HistroyMeetingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: FirestoreMethods().meetingsHistory, builder: (context, snapshot){
      if(snapshot.connectionState == ConnectionState.waiting){
        return const Center(child: CircularProgressIndicator(),);
      }
      final snapshoData = snapshot.data!.docs;
      return ListView.builder(itemCount: snapshoData.length, itemBuilder: (context, index) {
        return ListTile(title: Text('Room Name: ${snapshoData[index]['meetingName']}'), subtitle: Text(DateFormat('HH:mm dd/MM/yyyy').format(snapshoData[index]['createdAt'].toDate()).toString()),);
      });
    });
  }
}
