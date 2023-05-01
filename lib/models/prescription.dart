import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wasfa/models/doctor.dart';
import 'package:wasfa/models/medicine.dart';
import 'package:wasfa/models/patients.dart';
import 'package:wasfa/models/pharmacy.dart';

class Presciption {
  final String? id;
  final Patient? patient;
  final Doctor? doctor;
  final bool? isTaken;
  final Timestamp? timeCreated;
  final Timestamp? timeTaken;
  final Pharmacy? Validator;
  final Medicine? medicine;
  final String? quantity;
  final String? note;
  final String? dose;

  Presciption(
      {this.id,
      this.patient,
      this.dose,
      this.doctor,
      this.isTaken,
      this.timeCreated,
      this.timeTaken,
      this.Validator,
      this.medicine,
      this.quantity,
      this.note});
}
