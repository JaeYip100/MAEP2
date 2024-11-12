import 'package:flutter/material.dart';
import 'package:mae_assignment/data_model/tutor_data_model.dart';
import 'package:mae_assignment/repository/saved_tutor_repository.dart';
import 'package:mae_assignment/repository/tutor_repository.dart';

class SavedTutorProvider extends ChangeNotifier{
  // List<Tutor> _listToShow = [];
  List<Tutor> _savedTutorsInfo = [];
  bool _listIsLoading = false;

  // List<Tutor> get listToShow => _listToShow;
  List<Tutor> get savedTutorsInfo => _savedTutorsInfo;
  bool get listIsLoading => _listIsLoading;

  Future<void> ensureLoadList() async
  {
    if (_savedTutorsInfo.isEmpty)
    {
      _listIsLoading = true;
      notifyListeners();
      try{
        _savedTutorsInfo = await TutorRepository().getSavedTutorDetailsFromFirestore();
      }
      catch(e)
      {
        throw Exception("Connection failed");
      }
      finally
      {
        _listIsLoading = false;
        notifyListeners();
      }
    }
  }

  void toggleSaved(String tutorID, String name, String description, double averageRating)
  {
    SavedTutorRepository savedTutorRepository = SavedTutorRepository();
    if (_savedTutorsInfo.any((tutor) => tutor.tutorID == tutorID))
    {
      _savedTutorsInfo.removeWhere((tutor) => tutor.tutorID == tutorID);
      savedTutorRepository.remove(tutorID);
    }
    else
    {
      //Add to firestore.
      _savedTutorsInfo.add(Tutor(tutorID: tutorID, name: name, description: description, averageRating: averageRating));
      savedTutorRepository.add(tutorID);
    }
    notifyListeners();
  }

  bool isSaved(String tutorID)
  {
    return _savedTutorsInfo.any((tutor) => tutor.tutorID == tutorID);
  }
}