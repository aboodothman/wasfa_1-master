import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wasfa/doctor/auth/doctor_waiting.dart';
import 'package:wasfa/doctor/doctor_home.dart';
import 'package:wasfa/models/userData.dart';
import 'package:wasfa/pharmacy/pharmacy_home.dart';
import 'package:wasfa/splash_screen/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var _currentUsaer = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wasfa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _currentUsaer == null ? WelcomeScreen() : Wrapper(),
    );
  }
}

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  var _currentUsaer = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder(
              future: UserData().loadUser(_currentUsaer!.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (UserData().type == '1') {
                    if (UserData().isApproved) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        DoctorHome().launch(context,isNewTask: true);
                      });
                      return Center();
                    } else {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        DoctorWaitingApproval().launch(context);
                      });
                      return Center();
                    }
                  } else {
                    if(UserData().isApproved){
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                      PharmacyHomeScreen().launch(context,isNewTask: true);
                    });
                    return Center();
                    }else{
                       WidgetsBinding.instance.addPostFrameCallback((_) {
                        DoctorWaitingApproval().launch(context);
                      });
                      return Center();
                    }
                  }
                } else {
                  return SpinKitChasingDots(
                    color: Colors.red,
                  );
                }
              })
        ],
      ),
    );
  }
}
