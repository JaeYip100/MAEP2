import 'package:cloud_firestore/cloud_firestore.dart';

class Module {
  final String moduleID;
  final String name;

  const Module({
    required this.moduleID,
    required this.name,
  });

  factory Module.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Module(
      moduleID: data['moduleID'] ?? '',
      name: data['name'] ?? '',
    );
  }
}