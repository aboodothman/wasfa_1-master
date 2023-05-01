import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wasfa/components/main_button.dart';
import 'package:wasfa/components/main_textfield.dart';
import 'package:wasfa/components/spacing.dart';
import 'package:wasfa/main.dart';
import 'package:wasfa/pharmacy/auth/pharmacy_signup.dart';
import 'package:wasfa/services/auth.dart';

class PharmacyLoginScreen extends StatefulWidget {
  const PharmacyLoginScreen({super.key});

  @override
  State<PharmacyLoginScreen> createState() => _PharmacyLoginScreenState();
}

class _PharmacyLoginScreenState extends State<PharmacyLoginScreen> {
  bool isloading = false;
  String error = '';
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      body: isloading
          ? Center(
              child: SpinKitChasingDots(color: Colors.orange),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 180,
                        child: Image.asset(
                          "images/pharmacy.png",
                        ),
                      ), 
                       SizedBox(height: 20),
                      Text(
                        "Pharmacy Login",
                        style: GoogleFonts.raleway(
                          fontSize: 32,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      HeightSpacing(20),
                      MainTextFormField(
                        obscure: false,
                        hintText: 'Enter your email',
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
                        hintText: ' Enter your password',
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
                      Text(
                        error,
                        style: TextStyle(color: Colors.red),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MainButton(
                        color: Color.fromARGB(255, 35, 149, 162),
                        title: 'Sign in',
                        style: GoogleFonts.raleway(),
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isloading = true;
                            });
                            var result = await _auth.signInWithEmailAndPassword(
                                _emailController.text,
                                _passwordController.text);
                            if (result != null) {
                              Wrapper().launch(context, isNewTask: true);
                            } else {
                              setState(() {
                                error = 'email or password is incorrect';
                              });
                            }
                          }
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      GestureDetector(
                          onTap: () {
                            PharmacySignUp().launch(context);
                          },
                          child: Text(
                            'Do\'nt have account ? SignUp',
                            textAlign: TextAlign.center,
                          ))
                    ]),
              ),
            ),
    );
  }
}
