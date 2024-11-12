import 'package:flutter/material.dart';
import 'package:mae_assignment/data_model/module_data_model.dart';
import 'package:mae_assignment/custom_alert_dialog.dart';
import 'package:mae_assignment/repository/module_repository.dart';

class ModulePage extends StatelessWidget {
  const ModulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text(
          "Module",
          style: TextStyle(fontSize: 40, color: Colors.white),
        )),
        backgroundColor: const Color.fromARGB(255, 52, 128, 244),
      ),
      body: const Column(
        children: [
          SizedBox(
            height: 50,
            width: double.infinity,
            child: 
              Center(
                child: Text(
                  'Explore different interesting subjects based on your academic needs. Happy learning!'
                ),
              ),
          ),
          ModulePageBody(),
        ],
      ),
    );
  }
}

class ModulePageBody extends StatefulWidget {
  const ModulePageBody({super.key});

  @override
  State<ModulePageBody> createState() => _ModulePageBodyState();
}

class _ModulePageBodyState extends State<ModulePageBody> {
  List<Module> allModules = [];
  List<Module> listToShow = [];
  bool listIsLoading = false;

  void loadList() async
  {
    setState(() {
      listIsLoading = true;
    });
    try{
      allModules = await ModuleRepository().getModulesFromFirestore();
      setState(() {
        listToShow = allModules;
        listIsLoading = false;
      });
    }
    catch(e)
    {
      throw Exception("Connection failed");
    }
    
  }

  @override
  void initState() {
    try{
      loadList();
    }
    catch (e)
    {
      CustomAlertDialog().showAlertMessage(
        context,
        title: "Connection to firestore failed", 
        body: "Fail to retrieve modules. Please try again.",
      );
    }
    
    super.initState();
  }

  void refreshList(String searchKey)
  {
    setState(() {
      listIsLoading = true;
    });
    List<Module> result = [];
    if (searchKey.isEmpty)
    {
      result = allModules;
    }
    else
    {
      result = allModules.where((element) => element.name.toLowerCase().contains(searchKey.toLowerCase())).toList();
    }
    setState(() {
      listToShow = result;
      listIsLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: TextField(
            onChanged: (searchKey) => refreshList(searchKey),
            decoration: const InputDecoration(
              labelText: "Search for modules",
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        listIsLoading? 
          const CircularProgressIndicator():
          Expanded(child: listToShow.isEmpty? 
            const Center(child: Text("No modules found.")):
            ListView.builder(
              itemCount: listToShow.length,
              itemBuilder: (context, index)
              {
                return Container(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                  child: ListTile(
                  tileColor: const Color.fromARGB(255, 194, 193, 193),
                  title: Text(listToShow[index].name),
                  trailing: 
                    Tooltip(
                      message: 'Click to go to material page',
                      child: IconButton(
                        onPressed: (){
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (_) => /*Material Page Screen*/),
                          // );
                        }, 
                        icon: const Icon(Icons.arrow_forward),
                      ),
                    ),
                  ),
                );
              }
            )
          ),
      ],
    ));
  }
}