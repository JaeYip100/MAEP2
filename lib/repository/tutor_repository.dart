import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/data_model/saved_tutor_data_model.dart';
import 'package:flutter_application_1/data_model/tutor_data_model.dart';
import 'package:flutter_application_1/repository/saved_tutor_repository.dart';


class TutorRepository {
  Future<List<Tutor>> getTutorDetailsFromFirestore() async {
    List<Tutor> tutorDetails = [];
    try{
      //Get tutorID and tuteeID from saved tutor collection.
      // QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Tutor').get();
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Users').get();
      tutorDetails = querySnapshot.docs.map((doc) => Tutor.fromFirestore(doc)).toList();
    }
    catch (e)
    {
      throw Exception("Fail to retrieve tutor information");
    }
    return tutorDetails;
  }

  Future<List<Tutor>> getSavedTutorDetailsFromFirestore() async
  {
    List<Tutor> tutorDetails = [];
    try{
      SavedTutorRepository savedTutorRepository = SavedTutorRepository();
      List<SavedTutor> savedTutors = await savedTutorRepository.getSavedTutorFromFirestore();
      List<String> tutorIDs = savedTutors.map((savedTutor) => savedTutor.tutorID).toList();

      if (tutorIDs.isNotEmpty)
      {
        // CollectionReference tutorDetail = FirebaseFirestore.instance.collection('Tutor');
        // QuerySnapshot querySnapshot = await tutorDetail.where('tutorID', whereIn: tutorIDs).get();

        CollectionReference tutorDetail = FirebaseFirestore.instance.collection('Users');
        QuerySnapshot querySnapshot = await tutorDetail.where('uid', whereIn: tutorIDs).get();
        
        //Get the details of the saved tutors.
        for (var document in querySnapshot.docs)
        {
          tutorDetails.add(Tutor.fromFirestore(document));
        }
      }
    }
    catch (e)
    {
      throw Exception("Fail to retrieve saved tutor information");
    }

    return tutorDetails;
  }
}