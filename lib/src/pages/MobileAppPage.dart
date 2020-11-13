import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MobileAppPage extends StatelessWidget {
  Widget subPoint(String text) {
    return Text(
      text,
      style: GoogleFonts.openSans(
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget mainPoint(String text) {
    return Text(
      text,
      style: GoogleFonts.openSans(
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget cautionPoint(String text) {
    return Text(
      text,
      style: GoogleFonts.openSans(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            mainPoint('1. Joining a Meeting'),
            Container(
              margin: EdgeInsets.only(left: 25, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  subPoint(
                      '•	Enter the channel name at the provided text field and press the "Join" button. Please make sure that the robot and the doctor use the same channel name.'),
                  subPoint(
                      '•	Tap on the box with robot video to make the video feed from robot fullscreen and your video appears in the small box. It can also be viceversa.'),
                  subPoint(
                      '•	You can mute your audio, switch your camera and turn off your video using the respective buttons. You can end the call using the red call button or clicking the back button.'),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            mainPoint('2. Writing Notes in a Meeting and Viewing it Later.'),
            Container(
              margin: EdgeInsets.only(left: 25, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  subPoint(
                      '•	While in the meeting, you can see a text field at the top of the screen which will help you to save notes. After typing the note on the text field, click save button to save it. You can add any number of notes.'),
                  subPoint(
                      '•	To access the saved notes from the homescreen, press the "Notes" button and you can view all the note in the grey card. The card is scrollable!'),
                  subPoint(
                      '•	You can copy the text in the note to the clipboard by long pressing the note item.'),
                  subPoint(
                      '•	You can permanently delete an note by clicking the delete icon at the end of the note item.')
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            mainPoint('3. Accessing Google Sheet inside the app.'),
            Container(
              margin: EdgeInsets.only(left: 25, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  subPoint(
                      '•	At the first time "Open Excel" button is disabled as there is no google sheet url. To add an google sheet url, press the "Change Excel Url" button and paste the google sheet url in the text field and press "Change" button.'),
                  subPoint(
                      '•	Press the "Open Excel" button to open the google sheet anytime. An account selection option will appear. Please select the google account to which the sheet belongs to so that you can open the google sheet without any issues.'),
                  subPoint(
                      '•	You can change the url of excel sheet anytime using the "Change Excel Url" button.')
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '4. Caution',
              style: GoogleFonts.openSans(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 25, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cautionPoint(
                      '•	Please make sure you give permission for camera, microphone and file system access for the app to work properly.'),
                  cautionPoint(
                      '•	Channel name used for videocalling is case sensitive.'),
                  cautionPoint(
                      '•	Only one doctor can interact with the robot via video call,i.e., video call is a one to one setup.'),
                  cautionPoint(
                      '•	Please make sure you have a stable internet connection to avoid latency issues.'),
                  cautionPoint(
                      '•	Try not to clear the cache of the app to avoid unwanted data loss.'),
                  cautionPoint('•	Deleted note items cannot be retrieved.')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
