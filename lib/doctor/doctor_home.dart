import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wasfa/doctor/create_patient.dart';
import 'package:wasfa/doctor/doctor_pres_logs.dart';
import 'package:wasfa/doctor/patients_records.dart';
import 'package:wasfa/components/main_button.dart';
import 'package:wasfa/components/spacing.dart';
import 'package:wasfa/models/userData.dart';
import 'package:wasfa/splash_screen/welcome_screen.dart';
import 'package:wasfa/services/auth.dart';

class DoctorHome extends StatefulWidget {
  const DoctorHome({super.key});

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Color.fromARGB(255, 5, 49, 69),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [Text('Dr.'), Text(UserData().fullName)],
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
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Welcome back, Doctor . . . .',
                  style: GoogleFonts.raleway(
                      fontSize: 30, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 60),
                SizedBox(
                  height: 140,
                  child: Image.asset("images/doctor.png"),
                ),
                HeightSpacing(60),
                MainButton(
                    color: Color.fromARGB(255, 5, 49, 69),
                    title: 'Create a new patient profile',
                    style: GoogleFonts.raleway(),
                    onTap: (() {
                      CreatePatient().launch(context);
                    })),
                HeightSpacing(
                  40,
                ),
                MainButton(
                    color: Color.fromARGB(255, 5, 49, 69),
                    title: 'Patients records',
                    style: GoogleFonts.raleway(),
                    onTap: (() {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (_) => PatientRecords()));
                    })),
                HeightSpacing(40),
                MainButton(
                    color: Color.fromARGB(255, 5, 49, 69),
                    title: 'My prescriptions logs',
                    style: GoogleFonts.josefinSans(),
                    onTap: () {
                      DoctorPresLogs().launch(context);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
