import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ReviewRating{
  final String tuteeID;
  final String review;
  final double rating;
  final String datetime;

  ReviewRating({
    required this.tuteeID,
    required this.review,
    required this.rating,
    required this.datetime,
  });

  factory ReviewRating.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    
    Timestamp timestamp = data['dateTime'];
    DateTime dateTime = timestamp.toDate();
    String formattedDateTime = DateFormat('dd-MM-yyyy HH:mm').format(dateTime);

    return ReviewRating(
      tuteeID: data['uid'] ?? '',
      review: data['review'] ?? '',
      rating: data['rating'] ?? '',
      datetime: formattedDateTime,
    );
  }
}