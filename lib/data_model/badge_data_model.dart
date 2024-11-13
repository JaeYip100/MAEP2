import 'package:cloud_firestore/cloud_firestore.dart';

class Badge
{
  final int badgeID;
  final String name;
  final String description;
  final String imageURL;
  String status;

  Badge({
    required this.badgeID,
    required this.name,
    required this.description,
    required this.imageURL,
    required this.status,
  });

  factory Badge.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Badge(
      badgeID: data['badgeID'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageURL: data['imageURL'] ?? '',
      status: 'Locked',
    );
  }
}

class BadgeWithNoDetails
{
  final int badgeID;

  BadgeWithNoDetails({
    required this.badgeID,
  });

  factory BadgeWithNoDetails.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return BadgeWithNoDetails(
      badgeID: data['badgeID'] ?? '',
    );
  }
}