import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wasfa/models/doctor.dart';
import 'package:wasfa/models/medicine.dart';
import 'package:wasfa/models/patients.dart';
import 'package:wasfa/models/prescription.dart';

class DatabaseService {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference patientCollection =
      FirebaseFirestore.instance.collection('patients');
  final CollectionReference medicineCollection =
      FirebaseFirestore.instance.collection('medicine');
  final CollectionReference presciptionsCollection =
      FirebaseFirestore.instance.collection('presciptions');

  Future createDoctorUser(
      {String? name, String? email, String? phone, String? uid}) async {
    try {
      await userCollection.doc(uid).set({
        'fullName': name,
        'email': email,
        'phoneNumber': phone,
        'isApproved': false,
        'type': '1'
      });
    } catch (e) {
      print(e);
    }
  }

  Future createPharmacyUser(
      {String? name, String? email, String? phone, String? uid}) async {
    try {
      await userCollection.doc(uid).set({
        'fullName': name,
        'email': email,
        'phoneNumber': phone,
        'isApproved': false,
        'type': '2'
      });
    } catch (e) {
      print(e);
    }
  }

  Future getUserData(String? uid) async {
    try {
      return await userCollection.doc(uid).get();
    } catch (e) {
      print(e);
    }
  }

  Future createNewPatient(
      String? name, String? nati, String? date, String? doctorUid) async {
    try {
      return await patientCollection.doc().set({
        'fullName': name,
        'nationalNumber': nati,
        'birthDate': date,
        'doctorId': doctorUid,
        'createdAt': FieldValue.serverTimestamp()
      });
    } catch (e) {
      print(e);
    }
  }

  Future<List<Patient>> getDoctorPatients(String? doctorUid) async {
    List<Patient>? list = [];
    try {
      var query =
          await patientCollection.where('doctorId', isEqualTo: doctorUid).get();
      await Future.forEach(query.docs, (element) {
        list.add(Patient(
            id: element.id,
            fullName: element['fullName'],
            birthDate: element['birthDate'],
            nationalNumber: element['nationalNumber'],
            createdAt: element['createdAt']));
      });

      return list;
    } catch (e) {
      print(e);
      return list;
    }
  }

  Future<List<Medicine>> getMedicine() async {
    List<Medicine> list = [];
    try {
      var query = await medicineCollection.get();
      await Future.forEach(query.docs, (element) {
        list.add(Medicine(id: element.id, name: element['name']));
      });
      return list;
    } catch (e) {
      print(e);
      return list;
    }
  }

  Future CreateNewPres(String? medId, String? peshientId, String? doctorId,
      String? dose, String? quen, String? note) async {
    return await presciptionsCollection.add({
      'patient': peshientId,
      'doctor': doctorId,
      'isTaken': false,
      'timeCreated': FieldValue.serverTimestamp(),
      'timeTaken': FieldValue.serverTimestamp(),
      'Validator': 'non',
      'medicine': medId,
      'quantity': quen,
      'note': note,
      'dose': dose
    });
  }

  Future<List<Presciption>> getDoctorPres(String? uid) async {
    List<Presciption> list = [];
    try {
      var query =
          await presciptionsCollection.where('doctor', isEqualTo: uid).get();
      await Future.forEach(query.docs, (element) async {
        var patientInfo = await patientCollection.doc(element['patient']).get();
        var medInfo = await medicineCollection.doc(element['medicine']).get();
        list.add(Presciption(
          id: element.id,
          patient: Patient(
              id: patientInfo.id,
              fullName: patientInfo['fullName'],
              nationalNumber: patientInfo['nationalNumber']),
          isTaken: element['isTaken'],
          timeCreated: element['timeCreated'],
          timeTaken: element['timeTaken'],
          medicine: Medicine(id: medInfo.id, name: medInfo['name']),
          quantity: element['quantity'],
          note: element['note'],
        ));
      });
      return list;
    } catch (e) {
      print(e);
      return list;
    }
  }

    Future<List<Presciption>> getPharmacyPres(String? uid) async {
    List<Presciption> list = [];
    try {
      var query =
          await presciptionsCollection.where('Validator', isEqualTo: uid).get();
      await Future.forEach(query.docs, (element) async {
        var patientInfo = await patientCollection.doc(element['patient']).get();
        var medInfo = await medicineCollection.doc(element['medicine']).get();
        var doctorInfo = await userCollection.doc(element['doctor']).get();
        list.add(Presciption(
          id: element.id,
          doctor: Doctor(
              id: doctorInfo.id,
              fullName: doctorInfo['fullName'],
              phoneNumber: doctorInfo['phoneNumber']),
          patient: Patient(
              id: patientInfo.id,
              fullName: patientInfo['fullName'],
              nationalNumber: patientInfo['nationalNumber']),
          isTaken: element['isTaken'],
          timeCreated: element['timeCreated'],
          timeTaken: element['timeTaken'],
          medicine: Medicine(id: medInfo.id, name: medInfo['name']),
          quantity: element['quantity'],
          note: element['note'],
        ));
      });
      return list;
    } catch (e) {
      print(e);
      return list;
    }
  }

  Future getPatient(String? uid) async {
    try {
      var query =
          await patientCollection.where('nationalNumber', isEqualTo: uid).get();
      if (query.docs.isEmpty) {
        return null;
      } else {
        return Patient(
            id: query.docs.first.id,
            fullName: query.docs.first['fullName'],
            createdAt: query.docs.first['createdAt'],
            birthDate: query.docs.first['birthDate'],
            nationalNumber: query.docs.first['nationalNumber']);
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Presciption>> getPatientPres(String? uid) async {
    List<Presciption> list = [];
    try {
      var query =
          await presciptionsCollection.where('patient', isEqualTo: uid).get();
      await Future.forEach(query.docs, (element) async {
        var patientInfo = await patientCollection.doc(element['patient']).get();
        var medInfo = await medicineCollection.doc(element['medicine']).get();
        var doctorInfo = await userCollection.doc(element['doctor']).get();
        list.add(Presciption(
          id: element.id,
          doctor: Doctor(
              id: doctorInfo.id,
              fullName: doctorInfo['fullName'],
              phoneNumber: doctorInfo['phoneNumber']),
          patient: Patient(
              id: patientInfo.id,
              fullName: patientInfo['fullName'],
              nationalNumber: patientInfo['nationalNumber']),
          isTaken: element['isTaken'],
          timeCreated: element['timeCreated'],
          timeTaken: element['timeTaken'],
          medicine: Medicine(id: medInfo.id, name: medInfo['name']),
          quantity: element['quantity'],
          note: element['note'],
        ));
      });
      return list;
    } catch (e) {
      print(e);
      return list;
    }
  }

  Future makePresTaken(String? presId, String? pharId) async {
    return await presciptionsCollection.doc(presId).update({
      'timeTaken': FieldValue.serverTimestamp(),
      'isTaken': true,
      'Validator': pharId
    });
  }
}
