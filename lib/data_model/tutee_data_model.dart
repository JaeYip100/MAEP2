import 'package:cloud_firestore/cloud_firestore.dart';

class Tutee{
  final String tuteeID;
  final String name;
  final String description;

  const Tutee({
    required this.tuteeID,
    required this.name,
    required this.description,
  });

  factory Tutee.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Tutee(
      tuteeID: data['uid'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
    );
  }

  String nameFromFirestore(DocumentSnapshot doc)
  {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return data['name'] ?? '';
  }
}