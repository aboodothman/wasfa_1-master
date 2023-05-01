import 'package:cloud_firestore/cloud_firestore.dart';

class Pharmacy {
  final String? id;
  final String? name;
  final String? phoneNumber;
  final Timestamp? createdAt;

  Pharmacy({this.id, this.name, this.phoneNumber, this.createdAt});
}
