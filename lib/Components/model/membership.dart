class Member {
  final String memId;
  final String name;
  final int phone;
  final String address;
  final int postoffice;
  final int wardno;
  final String place;
  final DateTime dob;
  final String bloodgroup;
  final String membergroup;
  final DateTime date;
  final bool isVerified;

  Member(
    this.name,
    this.phone,
    this.address,
    this.postoffice,
    this.wardno,
    this.place,
    this.dob,
    this.bloodgroup,
    this.membergroup,
    this.date,
    this.memId,
    this.isVerified,
  );
}
