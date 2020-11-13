import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RobotPage extends StatelessWidget {
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
            mainPoint('1. Controlling the Robot'),
            Container(
              margin: EdgeInsets.only(left: 25, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  subPoint('•	Turn on the Red Switch'),
                  subPoint(
                      '•	Check whether the battery indication lights blinks in a pattern for 3 times.'),
                  subPoint(
                      '•	Charge the battery if it is low (indicated by red led in the battery status lights).'),
                  subPoint(
                      '•	If it is sufficiently high, Turn on the Transmitter by puling up the rectangular switch in the right while pressing the round switch in the left as shown in the image.'),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    'assets/controller1.jpg',
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: 300,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  subPoint(
                      '•	Keep all the switches on the top in upright position and lower the left throttle towards down to pair the robot and transmitter. The screen will show “Binding OK” if the pairing is successful.'),
                  subPoint(
                      '•	Use the right throttle to navigate the robot and left throttle to switch the position of camera in the robot. The position of the camera will be the front of the robot and the controls will be configured automatically according to the frontside.'),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    'assets/controller2.jpg',
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: 300,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            mainPoint('2. Charging the Robot'),
            Container(
              margin: EdgeInsets.only(left: 25, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  subPoint(
                      '•	Connect the charging port of the given charger to charging point.'),
                  subPoint(
                      '•	Turn on the charger and verify whether the below screen appears.'),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    'assets/battery1.jpg',
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: 100,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  subPoint(
                      '•	Long press the Enter button. Battery checking will take place and below screen will appear.'),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    'assets/battery2.jpg',
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: 100,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  subPoint('•	Press enter to start charging.'),
                  subPoint(
                      '•	To check how much the battery is charged, turn off the charger and switch ON the robot. The LED lights indicates the charge of the battery.'),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            mainPoint('3. Using the video navigation'),
            Container(
              margin: EdgeInsets.only(left: 25, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  subPoint(
                      '•	Install and open "Easycap and UVC Player (FPViewer)" app from Play store.'),
                  subPoint('•	Connect the Receiver to phone using OTG.'),
                  subPoint(
                      '•	The app will show connected and a screen would appear if successful.'),
                  subPoint(
                      '•	Long Press the switch in Receiver to scan for video.'),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '4. Cautions',
              style: GoogleFonts.openSans(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cautionPoint(
                      '•	Charge the Robot when power is low (indicated by red led in battery indication).'),
                  cautionPoint(
                      '•	Do not turn on the bot switch while charging.'),
                  cautionPoint(
                      '•	Do not charge if the screen in the charger doesn’t match the above images.'),
                  cautionPoint(
                      '•	Do not change any settings in the charger. Only follow the above instructions.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
