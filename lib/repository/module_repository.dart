import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mae_assignment/data_model/module_data_model.dart';

class ModuleRepository {
  Future<List<Module>> getModulesFromFirestore() async
  {
    List<Module> modules = [];
    try{
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Module').get();
      for (var document in querySnapshot.docs)
      {
        modules.add(Module.fromFirestore(document));
      }
    }
    catch (e)
    {
      throw Exception("Fail to retrive modules");
    }
    return modules;
  }
}