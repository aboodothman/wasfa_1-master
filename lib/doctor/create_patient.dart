import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:wasfa/components/main_button.dart';
import 'package:wasfa/components/main_textfield.dart';
import 'package:wasfa/components/spacing.dart';
import 'package:wasfa/doctor/patients_records.dart';
import 'package:wasfa/models/userData.dart';
import 'package:wasfa/services/database.dart';

class CreatePatient extends StatefulWidget {
  const CreatePatient({super.key});

  @override
  State<CreatePatient> createState() => _CreatePatientState();
}

class _CreatePatientState extends State<CreatePatient> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _natController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
         toolbarHeight: 80,
        backgroundColor: Color.fromARGB(255, 5, 49, 69),
        title: Text('Create New Patient profile'),
      ),
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: isLoading
            ? Center(
                child: SpinKitChasingDots(color: Color.fromARGB(255, 5, 49, 69), ),
              )
            : Center(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("Please validate all information entered"
                            "in this form carefully and make sure  td"
                            "authinticate it with the patient goverment ID",style:GoogleFonts.raleway()), 
                             HeightSpacing(80),
                        MainTextFormField(
                          hintText: 'Patient full name',
                          obscure: false,
                          keyboard: TextInputType.name,
                          style: GoogleFonts.raleway(),
                          controller: _nameController,
                          validator: (value) {
                            if (value!.length < 7) {
                              return 'Your name should be more than 7 Char.';
                            }
                          },
                        ),
                        HeightSpacing(20),
                        MainTextFormField(
                          hintText: 'National Number',
                          keyboard: TextInputType.name,
                          style: GoogleFonts.raleway(),
                          obscure: false,
                          controller: _natController,
                          validator: (value) {
                            if (value!.length < 7) {
                              return 'Your National Number should be more than 7 Char.';
                            }
                          },
                        ),
                        HeightSpacing(20),
                        MainTextFormField(
                          hintText: 'Date of birth',
                          keyboard: TextInputType.text,
                          obscure: false,
                          controller: _birthController,
                          style: GoogleFonts.raleway(),
                          validator: (value) {
                            if (value!.length < 7) {
                              return 'Your Date of birth should be more than 7 Char.';
                            }
                          },
                        ),
                        HeightSpacing(70),
                        MainButton(
                          color: Color.fromARGB(255, 5, 49, 69),
                          title: 'Continue',
                          style: GoogleFonts.raleway(),
                          onTap: (() async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              await DatabaseService().createNewPatient(
                                  _nameController.text,
                                  _natController.text,
                                  _birthController.text,
                                  UserData().uid);
                              showTopSnackBar(
                                context.overlayState!,
                                CustomSnackBar.success(
                                  message: "Your Patient has been added !!",
                                ),
                              );
                              Navigator.pop(context);
                            }
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
