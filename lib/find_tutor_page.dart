import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mae_assignment/custom_alert_dialog.dart';
import 'package:mae_assignment/data_model/saved_tutor_data_model.dart';
import 'package:mae_assignment/data_model/tutor_data_model.dart';
import 'package:mae_assignment/provider/saved_tutor_provider.dart';
import 'package:mae_assignment/repository/saved_tutor_repository.dart';
import 'package:mae_assignment/repository/tutor_repository.dart';
import 'package:mae_assignment/tutor_review_page.dart';
import 'package:provider/provider.dart';

class FindTutorPage extends StatelessWidget {
  const FindTutorPage ({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          "Find Tutors",
          style: TextStyle(fontSize: 40, color: Colors.white),
        )),
        backgroundColor: const Color.fromARGB(255, 52, 128, 244),
      ),
      body: Column(children: [
        const SizedBox(
          height: 50,
          width: double.infinity,
          child: Center(
            child: Text('Find suitable tutors by looking through the reviews and ratings to meet your academic needs. Happy finding!'),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => SavedTutorProvider()..ensureLoadList(),
          child: const FindTutorPageBody(),
        ),
      ]),
    );
  }
}

class FindTutorPageBody extends StatefulWidget {
  const FindTutorPageBody ({super.key});

  @override
  State<FindTutorPageBody> createState() => _FindTutorPageBodyState();
}

class _FindTutorPageBodyState extends State<FindTutorPageBody> {
  SavedTutorRepository savedTutorRepository = SavedTutorRepository();
  List<bool> saved = [];
  List<SavedTutor> savedTutors = [];
  List<Tutor> allTutors = [];
  List<Tutor> listToShow = [];
  bool listIsLoading = false;

  void loadList() async
  {
    setState(() {
      listIsLoading = true;
    });
    try{
      allTutors = await TutorRepository().getTutorDetailsFromFirestore();
      savedTutors = await SavedTutorRepository().getSavedTutorFromFirestore();
      setState(() {
        listToShow = allTutors;
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
    List<Tutor> result = [];
    if (searchKey.isEmpty)
    {
      result = allTutors;
    }
    else
    {
      result = allTutors.where((element) => element.name.toLowerCase().contains(searchKey.toLowerCase()) || 
      element.description.toLowerCase().contains(searchKey.toLowerCase())).toList();
    }
    setState(() {
      listToShow = result;
      listIsLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SavedTutorProvider>(context);

    return Expanded(child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              onChanged: (searchKey) => refreshList(searchKey),
              decoration: const InputDecoration(
                labelText: "Search for tutors",
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          listIsLoading? 
            const CircularProgressIndicator():
            Expanded(child: listToShow.isEmpty? 
              const Center(child: Text("No tutors found.")): 
              ListView.builder(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                itemCount: listToShow.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: const Color.fromARGB(255, 194, 193, 193),
                    child: ListTile(
                      title: RatingBarIndicator(
                        rating: listToShow[index].averageRating,
                        itemSize: 10.0,
                        itemBuilder: (_, __) => const Icon(Icons.star, color: Colors.yellow),
                      ),
                      subtitle: InkWell(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Tutor Name: ${listToShow[index].name}"),
                            Text(listToShow[index].description),
                          ],
                        ),
                        onTap: () async{
                          final newAverageRating = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TutorReviewPage(
                                tutorID: listToShow[index].tutorID,
                                name: listToShow[index].name,
                                description: listToShow[index].description,
                                averageRating: listToShow[index].averageRating,
                              )
                            ),
                          );
                          if (newAverageRating != listToShow[index].averageRating)
                          {
                            setState(() {
                              listToShow[index].averageRating = newAverageRating;
                            });
                          }
                        },
                      ),
                      trailing: IconButton(
                        onPressed: () => provider.toggleSaved(listToShow[index].tutorID, listToShow[index].name, listToShow[index].description, listToShow[index].averageRating),
                        icon: (provider.isSaved(listToShow[index].tutorID))
                        ?const Icon(Icons.star, color: Colors.blue): 
                        const Icon(Icons.star_border),
                      ),
                    ),
                  );
                }
              ),
            ),
          ],
        )
    );
  }
}