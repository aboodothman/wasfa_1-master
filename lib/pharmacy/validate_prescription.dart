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
import 'package:wasfa/models/patients.dart';
import 'package:wasfa/pharmacy/pharmacy_pati_info.dart';
import 'package:wasfa/services/database.dart';


class ValidatePrescription extends StatefulWidget {
  const ValidatePrescription({super.key});

  @override
  State<ValidatePrescription> createState() => _ValidatePrescriptionState();
}

class _ValidatePrescriptionState extends State<ValidatePrescription> {
  bool isLoading = false;
    final _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  
         toolbarHeight: 80,
         backgroundColor: Color.fromARGB(255, 35, 149, 162),  
          shadowColor: Colors.black,
        title: Text('Validate Prescription')),
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      body: isLoading ? Center(child: SpinKitChasingDots(color: Colors.orange),): Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 70),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Please validate all information entered "
"in this form carefully and make sure  to"
"authinticate it with the patient goverment ID.",
      
                style: GoogleFonts.raleway(),
              ),
              HeightSpacing(70),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MainTextFormField(
                    hintText: 'National Number',
                    keyboard: TextInputType.name,
                    obscure: false,
                    style: GoogleFonts.raleway(),
                    controller: _textController,
                    validator: (value) {
                      if (value!.length < 6) {
                        return 'Your National Should Be more than 6 Char.';
                      }
                    },
                  ),
                  HeightSpacing(20),
                  MainButton(
                      color:  Color.fromARGB(255, 35, 149, 162),  
                      title: 'Search',
                      onTap: () async{
                        if(_formKey.currentState!.validate()){
                          setState(() {
                            isLoading = true;
                          });
                          var result = await DatabaseService().getPatient(_textController.text);
                          if(result == null){
                            setState(() {
                              isLoading = false;
                            });
                             showTopSnackBar(
                              context.overlayState!,
                              CustomSnackBar.error(
                                message: "there is no Patient ...",
                              ),
                            );
                          }else{
                            var data = result as Patient;
                            print(data);
                            pharmacypatients(patient: data,).launch(context);
                          }
                        }
                       
                      },
                      style: GoogleFonts.raleway()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
