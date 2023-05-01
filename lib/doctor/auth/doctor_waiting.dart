import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wasfa/components/main_button.dart';
import 'package:wasfa/components/main_textfield.dart';
import 'package:wasfa/components/spacing.dart';
import 'package:wasfa/services/auth.dart';

class DoctorWaitingApproval extends StatefulWidget {
  const DoctorWaitingApproval({super.key});

  @override
  State<DoctorWaitingApproval> createState() => _DoctorWaitingApprovalState();
}

class _DoctorWaitingApprovalState extends State<DoctorWaitingApproval> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 180,
                    child: Icon(
                      Icons.timer,
                      size: 160,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    "Waiting Approval",
                    style: GoogleFonts.raleway(
                      fontSize: 32,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
