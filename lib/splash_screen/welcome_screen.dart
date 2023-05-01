import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wasfa/doctor/auth/doctor_login.dart';
import 'package:wasfa/doctor/doctor_home.dart';
import 'package:wasfa/components/spacing.dart';
import 'package:wasfa/pharmacy/auth/pharmacy_login.dart';
import '../components/main_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  SizedBox( 
                     height: 180,
                    child: Image(
                      image: AssetImage("images/medical.png"),
                    ),
                  ),
                  HeightSpacing(30),
                  Text(
                    "Wasfa",
                    style: GoogleFonts.raleway(fontSize: 40),
                  ),
                ],
              ),
              HeightSpacing(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      DoctorLoginScreen().launch(context);
                    },
                    child: Column(
                      children: [
                        Icon(Icons.assignment_ind_rounded, size: 50),
                        Text(
                          'Doctor',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                  ),
                  GestureDetector(
                    onTap: () {
                      PharmacyLoginScreen().launch(context);
                    },
                    child: Column(
                      children: [
                        Icon(Icons.local_pharmacy, size: 50),
                        Text('Pharmacy',
                            style: TextStyle(fontWeight: FontWeight.w700))
                      ],
                    ),
                  )
                ],
              )
            ]),
      ),
    );
  }
}
