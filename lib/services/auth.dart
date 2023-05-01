import 'package:firebase_auth/firebase_auth.dart';
import 'package:wasfa/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  //create new doctor user
  Future createUserWithEmailAndPasswordDoctor(
    String email,
    String password,
    String name,
    String phone,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
          print(result.user);
      User? user = result.user;
      await DatabaseService().createDoctorUser(
          name: name, phone: phone, email: email, uid: user!.uid);
      return user.uid;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //create new pharmacy
    Future createUserWithEmailAndPasswordPharmacy(
    String email,
    String password,
    String name,
    String phone,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
          print(result.user);
      User? user = result.user;
      await DatabaseService().createPharmacyUser(
          name: name, phone: phone, email: email, uid: user!.uid);
      return user.uid;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

    Future signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      print(result);
      // ignore: unnecessary_null_comparison
      if (user!.uid != null) {
        await DatabaseService()
            .getUserData(user.uid);
      }

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
