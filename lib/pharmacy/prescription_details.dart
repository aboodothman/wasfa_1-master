import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wasfa/components/main_button.dart';
import 'package:wasfa/components/spacing.dart';
import 'package:wasfa/doctor/doctor_home.dart';
import 'package:wasfa/models/prescription.dart';

class Presciption_Details extends StatefulWidget {
  final Presciption? pres;
  const Presciption_Details({super.key, this.pres});

  @override
  State<Presciption_Details> createState() => _Presciption_DetailsState();
}

class _Presciption_DetailsState extends State<Presciption_Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
         
        toolbarHeight: 80,
        title: Text('Presciption Details'),
        backgroundColor: Color.fromARGB(255, 5, 49, 69),
      ),
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HeightSpacing(10),
            Text(
              'Patient Info : ',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
            HeightSpacing(40),
            Text(
              'name : ${widget.pres!.patient!.fullName}',
              style: GoogleFonts.raleway(
                  fontSize: 18, fontWeight: FontWeight.w500),
            ),
            HeightSpacing(10),
            Text(
              'nationalNumber : ${widget.pres!.patient!.nationalNumber}',
              style: GoogleFonts.raleway(
                  fontSize: 18, fontWeight: FontWeight.w500),
            ),
            HeightSpacing(40),
            Text(
              'Medicine Info : ',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
            8.height,
            Text(
              'name : ${widget.pres!.medicine!.name}',
              style: GoogleFonts.raleway(
                  fontSize: 18, fontWeight: FontWeight.w500),
            ),
            HeightSpacing(10),
            Text(
              'quan : ${widget.pres!.quantity}',
              style: GoogleFonts.raleway(
                  fontSize: 18, fontWeight: FontWeight.w500),
            ),
            HeightSpacing(30),
            Text(
              'isTaken : ',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
            8.height,
            widget.pres!.isTaken!
                ? Column(
                    children: [
                      Text(
                        'Taken',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        widget.pres!.timeTaken!.toDate().toString(),
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  )
                : Text(
                    'Not Taken',
                    style: GoogleFonts.raleway(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
