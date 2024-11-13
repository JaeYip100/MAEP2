import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mae_assignment/data_model/tutor_rating_review_data_model.dart';

class ReviewRepository {
  double avgRating = 0.0;

  Future<List<ReviewRating>> getReviewRatingforATutor(String tutorID) async
  {
    List<ReviewRating> reviewRatings = [];
    CollectionReference tutorCollection = FirebaseFirestore.instance.collection('Users');
    DocumentSnapshot documentSnapshot = await tutorCollection.doc(tutorID).get();

    if (documentSnapshot.exists)
    {
      QuerySnapshot querySnapshot = await tutorCollection.doc(tutorID).collection('ReviewRating').orderBy('dateTime', descending: true).get();

      if (querySnapshot.docs.isNotEmpty)
      {
        reviewRatings = querySnapshot.docs.map((doc) => ReviewRating.fromFirestore(doc)).toList();
      }
    }
    
    return reviewRatings;
  }
}
