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
import 'package:wasfa/doctor/doctor_home.dart';
import 'package:wasfa/models/medicine.dart';
import 'package:wasfa/models/patients.dart';
import 'package:wasfa/models/userData.dart';
import 'package:wasfa/services/database.dart';

class CreatePrescription extends StatefulWidget {
  final Patient? patient;
  const CreatePrescription({super.key, this.patient});

  @override
  State<CreatePrescription> createState() => _CreatePrescriptionState();
}

class _CreatePrescriptionState extends State<CreatePrescription> {
    final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  var currentSelectedValue;
  var selectedid;

  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _doseController = TextEditingController();
   final TextEditingController _quenController = TextEditingController();
    final TextEditingController _noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  
         toolbarHeight: 80,
        backgroundColor:Color.fromARGB(255, 5, 49, 69), 
        title: Text('Create a new presciption'),
      ),
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      body: isLoading
          ? Center(
              child: SpinKitChasingDots(color: Color.fromARGB(255, 5, 49, 69),  ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Patient : ${widget.patient!.fullName}',
                          style: GoogleFonts.raleway(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            fontSize: 18,
                          ),
                        ),
                        HeightSpacing(10),
                        Text(
                          'Choose the desired medicine!',
                          style: TextStyle(color: Colors.grey),
                        ),
                        HeightSpacing(20),
                        FutureBuilder(
                            future: DatabaseService().getMedicine(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                var list = snapshot.data as List<Medicine>;
                                return InputDecorator(
                                  decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black87,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black87,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black87,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      labelText: 'Select the Medicine',
                                      labelStyle: GoogleFonts.raleway()),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: currentSelectedValue,
                                      isDense: true,
                                      onChanged: (newValue) {
                                        print(newValue);
                                        setState(() {
                                          currentSelectedValue = newValue;
                                          selectedid = newValue;
                                        });
                                      },
                                      items: list.map((Medicine value) {
                                        return DropdownMenuItem<String>(
                                          value: value.id,
                                          child: Text(
                                            value.name!,
                                            style: GoogleFonts.raleway(),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                );
                              } else {
                                return Center(
                                  child: SpinKitChasingDots(color: Colors.orange),
                                );
                              }
                            }),
                        HeightSpacing(30),
                        MainTextFormField(
                          obscure: false,
                          hintText: 'Medicine Dose',
                          keyboard: TextInputType.name,
                          controller: _doseController,
                          style: GoogleFonts.raleway(),
                           validator: (value) {
                                if (value!.length < 2) {
                                  return 'Your Dose should be more than 7 Char.';
                                }
                              },
                        ),
                        HeightSpacing(30),
                        MainTextFormField(
                          obscure: false,
                          hintText: 'Quantity ',
                          keyboard: TextInputType.name,
                          controller: _quenController,
                          style: GoogleFonts.raleway(),
                           validator: (value) {
                                if (value!.length < 1) {
                                  return 'Your name QUN be more than 1 Char.';
                                }
                              },
                          
                        ),
                        HeightSpacing(30),
                        MainTextFormField(
                          obscure: false,
                          hintText: 'disease description',
                          keyboard: TextInputType.name,
                          controller: _noteController,
                          style: GoogleFonts.raleway(),
                           validator: (value) {
                                if (value!.length < 7) {
                                  return 'Your NOTE should be more than 7 Char.';
                                }
                              },
                        ),
                        HeightSpacing(40),
                        MainButton(
                          color: Color.fromARGB(255, 5, 49, 69),
                          title: 'Continue',
                          onTap: () async{
                           if(_formKey.currentState!.validate()){
                            setState(() {
                              isLoading = true;
                            });
                            await DatabaseService().CreateNewPres(selectedid, widget.patient!.id, UserData().uid, _doseController.text, _quenController.text, _noteController.text);
                            showTopSnackBar(
                              context.overlayState!,
                              CustomSnackBar.success(
                                message: "Your Presciption has been added !!",
                              ),
                            );
                           DoctorHome().launch(context,isNewTask: true);
                           }
                          },
                          style: GoogleFonts.raleway(),
                        ),
                      ]),
                ),
              ),
            ),
    );
  }
}
