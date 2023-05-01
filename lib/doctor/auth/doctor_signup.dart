import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wasfa/components/main_button.dart';
import 'package:wasfa/components/main_textfield.dart';
import 'package:wasfa/components/spacing.dart';
import 'package:wasfa/doctor/auth/doctor_waiting.dart';
import 'package:wasfa/services/auth.dart';

class DoctorSignUp extends StatefulWidget {
  const DoctorSignUp({super.key});

  @override
  State<DoctorSignUp> createState() => _DoctorSignUpState();
}

class _DoctorSignUpState extends State<DoctorSignUp> {
  bool isLoading = false;
  String? error = '';
  final AuthService? _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      body: isLoading
          ? Center(
              child: SpinKitChasingDots(color: Colors.orange),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 160,
                            child: Image.asset(
                              "images/doctor.png",
                            ),
                          ),
                          HeightSpacing(10),
                          Text(
                            "Doctor SignUp",
                            style: GoogleFonts.raleway(
                              fontSize: 32,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          HeightSpacing(20),
                          MainTextFormField(
                            obscure: false,
                            hintText: 'Enter your FullName',
                            keyboard: TextInputType.name,
                            style: GoogleFonts.raleway(),
                            controller: _nameController,
                            validator: (value) {
                              if (value!.length < 7) {
                                return 'Your name should be more than 7 Char.';
                              }
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          MainTextFormField(
                            obscure: false,
                            hintText: 'Enter your Email',
                            keyboard: TextInputType.name,
                            style: GoogleFonts.raleway(),
                            controller: _emailController,
                            validator: (value) {
                              if (value!.length == 0) {
                                return 'Please Enter Your Email';
                              }
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          MainTextFormField(
                            obscure: true,
                            hintText: ' Enter your Password',
                            keyboard: TextInputType.text,
                            style: GoogleFonts.raleway(),
                            controller: _passwordController,
                            validator: (value) {
                              if (value!.length < 6) {
                                return 'Your Password Should Be more than 6 Char.';
                              }
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          MainTextFormField(
                            obscure: false,
                            hintText: ' Enter your Phone',
                            keyboard: TextInputType.number,
                            style: GoogleFonts.raleway(),
                            controller: _phoneController,
                            validator: (value) {
                              if (value!.length != 10) {
                                return 'Your PhoneNumber should be 10 Char.';
                              }
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            error!,
                            style: TextStyle(color: Colors.red),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          MainButton(
                            color:  Color.fromARGB(255, 5, 49, 69),
                            title: 'Sign Up',
                            style: GoogleFonts.raleway(),
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                var result = await _auth!
                                    .createUserWithEmailAndPasswordDoctor(
                                        _emailController.text,
                                        _passwordController.text,
                                        _nameController.text,
                                        _phoneController.text);
                                if (result != null) {
                                  DoctorWaitingApproval()
                                      .launch(context, isNewTask: true);
                                } else {
                                  setState(() {
                                    error = 'There Is error , check your email';
                                    isLoading = false;
                                  });
                                }
                              }
                            },
                          ),
                        ]),
                  ),
                ),
              ),
            ),
    );
  }
}
