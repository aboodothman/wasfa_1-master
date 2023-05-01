import 'package:cloud_firestore/cloud_firestore.dart';

class Patient {
  final String? id;
  final String? fullName;
  final String? nationalNumber;
  final String? birthDate;
  final Timestamp? createdAt;

  Patient(
      {this.id,
      this.fullName,
      this.birthDate,
      this.createdAt,
      this.nationalNumber});
}
