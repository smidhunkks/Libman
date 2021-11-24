import 'package:cloud_firestore/cloud_firestore.dart' as store;
import 'package:libman/Components/model/membership.dart';

class UserService {
  final _firestore = store.FirebaseFirestore.instance;

  Future addMember(Member member) async {
    await _firestore.collection("member").doc().set(
      {
        "Name": member.name,
        "Phone": member.phone,
      },
    );
  }
}
