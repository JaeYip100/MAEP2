import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/data_model/saved_tutor_data_model.dart';


class SavedTutorRepository {
  
  
  void add(String tutorID) async
  {
    //Update the firestore.
    try {
      CollectionReference tuteeCollection = FirebaseFirestore.instance.collection("Users");
      DocumentSnapshot documentSnapshot = await tuteeCollection.doc(FirebaseAuth.instance.currentUser?.uid ?? "").get();
      
      if (documentSnapshot.exists)
      {
        CollectionReference savedTutorCollection = tuteeCollection.doc(FirebaseAuth.instance.currentUser?.uid ?? "").collection('savedTutor');
        await savedTutorCollection.add({"tutorID": tutorID});
      }
    } catch (e) {
      throw Exception('Fail to update favourite list');
    }
    // CollectionReference tuteeCollection = FirebaseFirestore.instance.collection("Tutee");
    // QuerySnapshot querySnapshot = await tuteeCollection.where('tuteeID', isEqualTo: tuteeID).get();
    
    // try {
    //   for (var document in querySnapshot.docs)
    //   {
    //     CollectionReference savedTutorCollection = tuteeCollection.doc(document.reference.id).collection("savedTutor");
    //     await savedTutorCollection.add({"tutorID": tutorID});
    //   }
    // }
    // catch (e)
    // {
    //   throw Exception('Fail to update favourite list');
    // }
  }

  void remove(String tutorID) async
  {
    try {
      CollectionReference tuteeCollection = FirebaseFirestore.instance.collection("Users");
      DocumentSnapshot documentSnapshot = await tuteeCollection.doc(FirebaseAuth.instance.currentUser?.uid ?? "").get();
      
      if (documentSnapshot.exists)
      {
        CollectionReference savedTutorCollection = tuteeCollection.doc(FirebaseAuth.instance.currentUser?.uid ?? "").collection('savedTutor');
        QuerySnapshot querySnapshot = await savedTutorCollection.where("tutorID", isEqualTo: tutorID).get();
      
        if (querySnapshot.docs.isNotEmpty)
        {
          for (var document in querySnapshot.docs)
          {
            document.reference.delete();
          }
        }
      
        await savedTutorCollection.add({"tutorID": tutorID});
      }
    } catch (e) {
      throw Exception('Fail to update favourite list');
    }
    // CollectionReference tuteeCollection = FirebaseFirestore.instance.collection("Tutee");
    // QuerySnapshot querySnapshot = await tuteeCollection.where('tuteeID', isEqualTo: tuteeID).get();
    
    // try{
    //   for (var document in querySnapshot.docs)
    //   {
    //     CollectionReference savedTutorCollection = tuteeCollection.doc(document.reference.id).collection("savedTutor");
    //     QuerySnapshot querySnapshot1 = await savedTutorCollection.where('tutorID', isEqualTo: tutorID).get();

    //     for (var document1 in querySnapshot1.docs)
    //     {
    //       document1.reference.delete();
    //     }
    //   }
    // }
    // catch (e)
    // {
    //   throw Exception('Fail to update favourite list');
    // }
  }

  Future<List<SavedTutor>> getSavedTutorFromFirestore() async
  {
    List<SavedTutor> savedTutors = [];
    //Get tutorID and tuteeID from saved tutor collection.
    try {
      CollectionReference tuteeCollection = FirebaseFirestore.instance.collection("Users");
      DocumentSnapshot documentSnapshot = await tuteeCollection.doc(FirebaseAuth.instance.currentUser?.uid ?? "").get();
      
      if (documentSnapshot.exists)
      {
        CollectionReference savedTutorCollection = tuteeCollection.doc(FirebaseAuth.instance.currentUser?.uid ?? "").collection('savedTutor');
        QuerySnapshot querySnapshot = await savedTutorCollection.get();

        if (querySnapshot.docs.isNotEmpty)
        {
          savedTutors = querySnapshot.docs.map((doc) => SavedTutor.fromFirestore(doc)).toList();
        }
      }
    }
    catch (e)
    {
      throw Exception("Fail to retrieve saved tutors.");
    }
    // CollectionReference tuteeCollection = FirebaseFirestore.instance.collection('Tutee');
    // QuerySnapshot querySnapshot = await tuteeCollection.where('tuteeID', isEqualTo: tuteeID).get();
    
    // if (querySnapshot.docs.isNotEmpty)
    // {
    //   for (var document in querySnapshot.docs)
    //   {
    //     CollectionReference savedTutor = tuteeCollection.doc(document.reference.id).collection('savedTutor');
    //     QuerySnapshot querySnapshot1 = await savedTutor.get();

    //     for (var document1 in querySnapshot1.docs)
    //     {
    //       savedTutors.add(SavedTutor.fromFirestore(document1));
    //     }
    //   }
    // }
    return savedTutors;
  }
}