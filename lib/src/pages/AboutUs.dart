import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUs extends StatelessWidget {
  static const routeName = '/aboutus';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Middle Man',
          style: GoogleFonts.openSans(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            children: [
              Image.asset(
                'assets/logob.png',
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Middleman Robot is designed to assist health staff to easily communicate and transport food/medicine to patients without any physical contact.\n The robot has the following features: \n•	RF based remote control with a range up to 500m.\n•	Video feed to mobile phone for navigation.\n•	An onboard mobile phone to communicate with patients remotely.\n•	Slim and light design for easy lifting\n•	3 hours battery backup\n•	Can carry up to 15 kg of weight.\n\n The Robot is designed and fabricated at Government Engineering College Bartonhill by the R&D team of the college.",
                style: GoogleFonts.openSans(
                  fontSize: 14,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              Text(
                "Version 1.0.0",
                style: GoogleFonts.openSans(
                  fontSize: 14,
                  color: Colors.grey.withOpacity(0.86),
                ),
              ),
              Text(
                "Designed and Developed by",
                style: GoogleFonts.openSans(
                  fontSize: 14,
                  color: Colors.grey.withOpacity(0.86),
                ),
              ),
              Text(
                "GADS",
                style: GoogleFonts.openSans(
                  fontSize: 25,
                  color: Colors.black54,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
