import 'package:cloud_firestore/cloud_firestore.dart';

class Tutor{
  final String tutorID;
  final String name;
  final String description;
  double averageRating;

  Tutor({
    required this.tutorID,
    required this.name,
    required this.description,
    required this.averageRating,
  });

  factory Tutor.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Tutor(
      tutorID: data['uid'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      averageRating: data['averageRating'] ?? 0.0,
    );
  }
}