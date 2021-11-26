import 'package:cloud_firestore/cloud_firestore.dart' as store;
import 'package:libman/Components/model/membership.dart';

class UserService {
  final _firestore = store.FirebaseFirestore.instance;

  get idGen async {
    int? memId;

    final query = await _firestore
        .collection("member")
        .orderBy("mem_id", descending: true)
        .limit(1)
        .get();
    //print("query doc ${query.docs[0].id}");

    // query.snapshots().forEach(
    //   (element) {
    //     memId = int.parse(element.docs[0].id.toString().substring(3)) + 1;
    //   },
    // );
    memId =
        query.docs.isEmpty ? 1 : int.parse(query.docs[0].id.substring(3)) + 1;
    print("inside getter:${memId.toString().length}");
    String idString = memId.toString().length == 1
        ? "VPL00$memId"
        : (memId.toString().length == 2 ? "VPL0$memId" : "VPL$memId");
    return idString;
  }

  Future addMember(Member member) async {
    // store.CollectionReference collectionRef = _firestore.collection("member");
    // store.Query query =
    //     collectionRef.orderBy("mem_id", descending: true).limit(1);
    String? idString = await idGen;
    print("inside addmem:$idString");
    await _firestore.collection("member").doc(idString).set(
      {
        "name": member.name,
        "phone": member.phone,
        "address": member.address,
        "postoffice": member.postoffice,
        "wardno": member.wardno,
        "place": member.place,
        "dob": member.dob,
        "bloodgroup": member.bloodgroup,
        "membergroup": member.membergroup,
        "date": member.date,
        "isVerified": false,
        "mem_id": int.parse(idString!.substring(3))
      },
    ).then((value) => print("set"));
  }
}
