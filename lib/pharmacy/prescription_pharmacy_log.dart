import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wasfa/components/main_button.dart';
import 'package:wasfa/components/main_textfield.dart';
import 'package:wasfa/components/spacing.dart';
import 'package:wasfa/models/prescription.dart';
import 'package:wasfa/models/userData.dart';
import 'package:wasfa/pharmacy/prescription_details.dart';
import 'package:wasfa/services/database.dart';

class PharmacyPresLogs extends StatefulWidget {
  const PharmacyPresLogs({super.key});

  @override
  State<PharmacyPresLogs> createState() => _PharmacyPresLogsState();
}

class _PharmacyPresLogsState extends State<PharmacyPresLogs> {
  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        toolbarHeight: 80,
        backgroundColor:Color.fromARGB(255, 35, 149, 162),   
        title: Text('My Presciptions log')),
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 70),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeightSpacing(10),
              FutureBuilder(
                  future: DatabaseService().getPharmacyPres(UserData().uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      var list = snapshot.data as List<Presciption>;
                      return list.isEmpty
                          ? Center(
                              child: Text('there is no result'),
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
                                     Presciption_Details(pres: list[i],).launch(context);
                                    },
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          children: [
                                            Text(list[i].patient!.fullName!),
                                             Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                               children: [
                                                 Text(list[i].medicine!.name!),
                                                  Text(' - '),
                                                 Text(list[i].quantity!),
                                               ],
                                             ),
                                              Text(list[i].timeCreated!.toDate().toString()),
                                              list[i].isTaken! ? Text('Taken') : Text('Not Taken'),
                                          ],
                                        ),
                                      ),
                                      height: 120,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color.fromARGB(255, 255, 255, 255),  
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
                  })
            ],
          ),
        ),
      ),
    );
  }
}
