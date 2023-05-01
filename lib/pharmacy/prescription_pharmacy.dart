import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:wasfa/components/main_button.dart';
import 'package:wasfa/components/spacing.dart';
import 'package:wasfa/doctor/doctor_home.dart';
import 'package:wasfa/models/prescription.dart';
import 'package:wasfa/models/userData.dart';
import 'package:wasfa/pharmacy/pharmacy_home.dart';
import 'package:wasfa/services/database.dart';

class PresciptionPharmacyScreen extends StatefulWidget {
  final Presciption? pres;
  const PresciptionPharmacyScreen({super.key, this.pres});

  @override
  State<PresciptionPharmacyScreen> createState() =>
      _PresciptionPharmacyScreenState();
}

class _PresciptionPharmacyScreenState extends State<PresciptionPharmacyScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 35, 149, 162),
        toolbarHeight: 80,
        title: Text('Presciption Details'),
      ),
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      body: isLoading
          ? Center(
              child: SpinKitChasingDots(color: Colors.orange),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  HeightSpacing(10),
                  Text(
                    'Patient Info : ',
                    style: GoogleFonts.raleway(fontSize: 30),
                  ),
                  8.height,
                  Text(
                    'name : ${widget.pres!.patient!.fullName}',
                    style: GoogleFonts.raleway(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                      'nationalNumber : ${widget.pres!.patient!.nationalNumber}',
                    style: GoogleFonts.raleway(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  16.height,
                  Text('Medicine Info : ',
                    style: GoogleFonts.raleway(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  8.height,
                  Text('name : ${widget.pres!.medicine!.name}',
                    style: GoogleFonts.raleway(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text('quan : ${widget.pres!.quantity}',
                    style: GoogleFonts.raleway(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  16.height,
                  Text('isTaken : ',
                    style: GoogleFonts.raleway(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  8.height,
                  widget.pres!.isTaken!
                      ? Column(
                          children: [
                            Text('Taken',
                              style: GoogleFonts.raleway(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Text(widget.pres!.timeTaken!.toDate().toString())
                          ],
                        )
                      : Text('Not Taken',
                          style: GoogleFonts.raleway(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                  SizedBox(
                    height: 30,
                  ),
                  MainButton(
                      color: Color.fromARGB(255, 35, 149, 162),
                      title: 'Make Taken',
                      onTap: () async {
                        showConfirmDialogCustom(context,
                            dialogType: DialogType.UPDATE,
                            title:
                                'are you sure , you want to change this presciption status to taken by you ?',
                            onAccept: (s) async {
                          setState(() {
                            isLoading = true;
                          });

                          await DatabaseService()
                              .makePresTaken(widget.pres!.id, UserData().uid);

                          showTopSnackBar(
                            context.overlayState!,
                            CustomSnackBar.success(
                              message:
                                  "Your Presciption has been Taken By You !!",
                            ),
                          );
                          PharmacyHomeScreen().launch(context, isNewTask: true);
                        });
                      },
                      style: GoogleFonts.raleway())
                ],
              ),
            ),
    );
  }
}
