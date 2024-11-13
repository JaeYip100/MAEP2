import 'package:cloud_firestore/cloud_firestore.dart';

class SavedTutor{
  final String tutorID;

  SavedTutor({
    required this.tutorID,
  });

  factory SavedTutor.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return SavedTutor(
      tutorID: data['uid'] ?? '',
    );
  }
}