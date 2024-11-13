import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/data_model/tutee_data_model.dart';

class TuteeRepository {

  Future<List<String>> getTuteeName(List<String> tuteeIDs) async
  {
    Tutee tutee = const Tutee(tuteeID: "", name: "", description: "");
    Map<String, String> tuteeIdToNameMap = {};
    List<String> tuteeNames = [];
    // CollectionReference tuteeCollection = FirebaseFirestore.instance.collection('Tutee');
    CollectionReference tuteeCollection = FirebaseFirestore.instance.collection('Users');
    QuerySnapshot querySnapshot = await tuteeCollection.where('uid', whereIn: tuteeIDs).get();

    if (querySnapshot.docs.isNotEmpty)
    {
      for (var document in querySnapshot.docs)
      {
        tuteeIdToNameMap[document['uid']] = document['name'];
        tuteeNames.add(tutee.nameFromFirestore(document));
      }
    }

    for (var tuteeID in tuteeIDs) {

      if (tuteeIdToNameMap.containsKey(tuteeID)) {
        tuteeNames.add(tuteeIdToNameMap[tuteeID]!);
      }
    }
    
    return tuteeNames;
  }

  Future<String> getName(String tuteeID) async
  {
    // CollectionReference tuteeCollection = FirebaseFirestore.instance.collection('Tutee');
    // QuerySnapshot querySnapshot = await tuteeCollection.where("tuteeID", isEqualTo: tuteeID).get();
    CollectionReference tuteeCollection = FirebaseFirestore.instance.collection('Users');
    DocumentSnapshot documentSnapshot = await tuteeCollection.doc(tuteeID).get();

    if (documentSnapshot.exists)
    {
      return documentSnapshot.get('name') ?? '';
    }

    // if (querySnapshot.docs.isNotEmpty)
    // {
    //   return querySnapshot.docs.first['name'] ?? '';
    // }
    return "";
  }
}