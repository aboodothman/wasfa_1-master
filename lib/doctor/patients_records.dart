import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wasfa/components/main_textfield.dart';
import 'package:wasfa/components/spacing.dart';
import 'package:wasfa/doctor/create_prescripation.dart';
import 'package:wasfa/models/patients.dart';
import 'package:wasfa/models/userData.dart';
import 'package:wasfa/services/database.dart';

class PatientRecords extends StatefulWidget {
  const PatientRecords({super.key});

  @override
  State<PatientRecords> createState() => _PatientRecordsState();
}

class _PatientRecordsState extends State<PatientRecords> {
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 5, 49, 69),
        toolbarHeight: 80,
        title: Text('Patients Records'),
      ),
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              MainTextField(
                obscure: false,
                hintText: 'Search by name',
                keyboard: TextInputType.text,
                style: GoogleFonts.raleway(),
                controller: _nameController,
              ),
              HeightSpacing(10),
              FutureBuilder(
                  future: DatabaseService().getDoctorPatients(UserData().uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      var list = snapshot.data as List<Patient>;
                      return list.isEmpty
                          ? Center(
                              child: Text('there is no patients'),
                            )
                          : SizedBox(
                              height: MediaQuery.of(context).size.height * 0.8,
                              child: ListView.builder(
                                  itemCount: list.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        CreatePrescription(
                                          patient: list[index],
                                        ).launch(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 240, 240, 243),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color.fromARGB(
                                                    255, 111, 103, 103),
                                                blurRadius: 4,
                                                offset: Offset(4, 8),
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Text(list[index].fullName!,
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                  HeightSpacing(10),
                                                  Text(
                                                    list[index].nationalNumber!,
                                                    style: TextStyle(
                                                        color:Colors.black  )
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            );
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
