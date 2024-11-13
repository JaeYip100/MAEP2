import 'package:flutter/material.dart';
import 'provider/saved_tutor_provider.dart';
import 'package:provider/provider.dart';

class SavedTutorPage extends StatelessWidget {
  const SavedTutorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        title: const Center(
            child: Text(
          "Saved",
          style: TextStyle(fontSize: 40, color: Colors.white),
        )),
        backgroundColor: const Color.fromARGB(255, 52, 128, 244),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
            child: Center(
              child: Text('Find tutors that you have saved here.'),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => SavedTutorProvider()..ensureLoadList(),
            child: const SavedTutorBody()
          ),
        ],
      ),
    );
  }
}

class SavedTutorBody extends StatefulWidget {
  const SavedTutorBody({super.key});

  @override
  State<SavedTutorBody> createState() => _SavedTutorBodyState();
}

class _SavedTutorBodyState extends State<SavedTutorBody> {

  @override
  Widget build(BuildContext context) {
    return Consumer<SavedTutorProvider>(
      builder: (context, provider, child) {
        final listToShow = provider.savedTutorsInfo;
        int length = listToShow.length;

        return 
          provider.listIsLoading
            ? const CircularProgressIndicator():
            Expanded(
              child: length == 0
            ? const Center(child: Text("No saved tutors.")):
              ListView.builder(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                itemCount: length,
                itemBuilder: (context, index)
                {
                  return Container(
                    color: const Color.fromARGB(255, 194, 193, 193),
                    child: ListTile(
                    title: Text(listToShow[index].name),
                    subtitle: Text(listToShow[index].description),
                    trailing: IconButton(
                      onPressed: () {
                        provider.toggleSaved(listToShow[index].tutorID, listToShow[index].name, listToShow[index].description, listToShow[index].averageRating);
                      }, 
                      icon: provider.isSaved(listToShow[index].tutorID)? 
                        const Icon(Icons.star, color: Colors.blue):
                        const Icon(Icons.star_border),
                    ),
                  )
                  );
                }
              ),
            );
      },);

    
  }
}