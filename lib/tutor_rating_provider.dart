import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:mae_assignment/data_model/tutor_rating_review_data_model.dart';
import 'package:mae_assignment/repository/review_repository.dart';
import 'package:mae_assignment/repository/tutee_repository.dart';
import 'package:mae_assignment/tutor_review_page.dart';

class TutorRatingProvider with ChangeNotifier {
  List<CustomList> listToShow = [];
  
  void loadReviews () async {
    var userID = FirebaseAuth.instance.currentUser?.uid;

    if (userID != null)
    {
      List<String> tuteeIDs = [];
      List<ReviewRating> reviewRatings = [];
      reviewRatings = await ReviewRepository().getReviewRatingforATutor(userID);
      for (var review in reviewRatings) {
        tuteeIDs.add(review.tuteeID);
      }
      List<String> tuteeNames = await TuteeRepository().getTuteeName(tuteeIDs);
      
      for (int i = 0; i < tuteeIDs.length; i++) {
        listToShow.add(CustomList(tuteeNames[i], reviewRatings[i].review, reviewRatings[i].rating, reviewRatings[i].datetime));
      }
      notifyListeners();
    }
    else
    {
      throw Exception("Fail to retrieve reviews.");
    }
  }
}