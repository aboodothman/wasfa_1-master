import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wasfa/components/main_button.dart';
import 'package:wasfa/components/spacing.dart';
import 'package:wasfa/models/patients.dart';
import 'package:wasfa/models/prescription.dart';
import 'package:wasfa/pharmacy/prescription_details.dart';
import 'package:wasfa/pharmacy/prescription_pharmacy.dart';
import 'package:wasfa/services/database.dart';

class pharmacypatients extends StatefulWidget {
  final Patient? patient;
  const pharmacypatients({super.key, this.patient});

  @override
  State<pharmacypatients> createState() => _pharmacypatientsState();
}

class _pharmacypatientsState extends State<pharmacypatients> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Color.fromARGB(255, 35, 149, 162),
          title: Text('Patient information')),
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              HeightSpacing(20),
              Row(
                children: [
                  Icon(Icons.person),
                  8.width,
                  Text(
                    widget.patient!.fullName!,
                    style: GoogleFonts.raleway(fontSize: 22),
                  ),
                ],
              ),
              HeightSpacing(30),
              Row(
                children: [
                  Icon(Icons.add_card),
                  8.width,
                  Text(
                    widget.patient!.nationalNumber!,
                    style: GoogleFonts.raleway(fontSize: 22),
                  ),
                ],
              ),
              HeightSpacing(30),
              Row(
                children: [
                  Icon(Icons.calendar_month),
                  8.width,
                  Text(
                    widget.patient!.createdAt!.toDate().toString(),
                    style: GoogleFonts.raleway(fontSize: 22),
                  ),
                ],
              ),
              HeightSpacing(30),
              Row(
                children: [
                  Icon(Icons.history),
                  8.width,
                  Text(
                    'Presciption history',
                    style: GoogleFonts.raleway(fontSize: 22),
                  ),
                ],
              ),
              HeightSpacing(10),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.60,
                child: FutureBuilder(
                    future:
                        DatabaseService().getPatientPres(widget.patient!.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        var list = snapshot.data as List<Presciption>;
                        return list.isEmpty
                            ? Center(
                                child: Text('There is no Presciption'),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: list.length,
                                itemBuilder: (context, i) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        PresciptionPharmacyScreen(
                                          pres: list[i],
                                        ).launch(context);
                                      },
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Column(
                                            children: [
                                              Text(list[i].patient!.fullName!),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(list[i].medicine!.name!),
                                                  Text(' - '),
                                                  Text(list[i].quantity!),
                                                ],
                                              ),
                                              Text(list[i]
                                                  .timeCreated!
                                                  .toDate()
                                                  .toString()),
                                              list[i].isTaken!
                                                  ? Text('Taken')
                                                  : Text('Not Taken'),
                                            ],
                                          ),
                                        ),
                                        height: 120,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10), 
                                               color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 111, 103, 103),
                                              blurRadius: 4,
                                              offset: Offset(4, 8),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                      } else {
                        return Center(
                          child: SpinKitChasingDots(color: Colors.orange),
                        );
                      }
                    }),
              )
            ]),
      ),
    );
  }
}
