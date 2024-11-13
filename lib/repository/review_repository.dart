import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/data_model/tutor_rating_review_data_model.dart';

class ReviewRepository {
  double avgRating = 0.0;

  Future<List<ReviewRating>> getReviewRatingforATutor(String tutorID) async
  {
    List<ReviewRating> reviewRatings = [];
    CollectionReference tutorCollection = FirebaseFirestore.instance.collection('Users');
    DocumentSnapshot documentSnapshot = await tutorCollection.doc(tutorID).get();

    if (documentSnapshot.exists)
    {
      QuerySnapshot querySnapshot = await tutorCollection.doc(tutorID).collection('ReviewRating').get();

      if (querySnapshot.docs.isNotEmpty)
      {
        reviewRatings = querySnapshot.docs.map((doc) => ReviewRating.fromFirestore(doc)).toList();
      }
    }
    // CollectionReference tutorCollection = FirebaseFirestore.instance.collection('Tutor');
    // QuerySnapshot querySnapshot = await tutorCollection.where('tutorID', isEqualTo: tutorID).get();

    // if (querySnapshot.docs.isNotEmpty)
    // {
    //   for (var document in querySnapshot.docs)
    //   {
    //     avgRating = Tutor.fromFirestore(document).averageRating;
    //     QuerySnapshot querySnapshot1 = await tutorCollection.doc(document.reference.id).collection('ReviewRating').orderBy('dateTime', descending: true).get();
    //     for (var document1 in querySnapshot1.docs) {
    //       reviewRatings.add(ReviewRating.fromFirestore(document1));
    //     }
    //   }
    // }
    
    return reviewRatings;
  }
}
