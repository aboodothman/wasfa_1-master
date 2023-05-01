import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wasfa/components/main_button.dart';
import 'package:wasfa/components/spacing.dart';
import 'package:wasfa/models/userData.dart';
import 'package:wasfa/pharmacy/validate_prescription.dart';
import 'package:wasfa/splash_screen/welcome_screen.dart';
import 'package:wasfa/services/auth.dart';

import 'prescription_pharmacy_log.dart';

class PharmacyHomeScreen extends StatefulWidget {
  const PharmacyHomeScreen({super.key});

  @override
  State<PharmacyHomeScreen> createState() => _PharmacyHomeScreenState();
}

class _PharmacyHomeScreenState extends State<PharmacyHomeScreen> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        toolbarHeight: 80, 
         backgroundColor: Color.fromARGB(255, 35, 149, 162),  
          shadowColor:Color.fromARGB(255, 0, 0, 0),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [Text('Welcome Back, '), Text(UserData().fullName)],
            ),
            GestureDetector(
                onTap: () {
                  showConfirmDialogCustom(context,
                      title: 'Do you want to log out ?', onAccept: (s) async {
                    await _auth.signOut();
                    WelcomeScreen().launch(context);
                  });
                },
                child: Icon(Icons.logout))
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 160),
        child: Column(
         
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox( 
               height: 160,
              child: Image.asset('images/pharmacy.png'),),
               SizedBox(height: 70),
            MainButton(
              color: Color.fromARGB(255, 35, 149, 162),   
              
              title: 'Check patient records',
              onTap: () {
                ValidatePrescription().launch(context);
              },
              style: GoogleFonts.raleway(),
            ),
            HeightSpacing(20),
            MainButton(
              color: Color.fromARGB(255, 35, 149, 162),  
              title: 'My prescriptions logs',
              onTap: () {
                PharmacyPresLogs().launch(context);
              },
              style: GoogleFonts.raleway(),
            ),
          ],
        ),
      ),
    );
  }
}
