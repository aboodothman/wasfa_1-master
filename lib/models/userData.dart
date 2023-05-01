import 'package:wasfa/services/database.dart';

class UserData {
  String uid = '';
  String fullName = '';
  String phoneNumber = '';
  String type = '';
  String email = '';
  bool isApproved = false;

  static final UserData _singleton = UserData._internal();

  factory UserData() {
    return _singleton;
  }
  UserData._internal();

  Future<UserData> loadUser(String uid) async {
    var userData = await DatabaseService().getUserData(uid);
    this.uid = uid;
    this.fullName = userData['fullName'];
    this.phoneNumber = userData['phoneNumber'];
    this.type = userData['type'];
    this.isApproved = userData['isApproved'];
    this.email = userData['email'];
    return this;
  }
}
