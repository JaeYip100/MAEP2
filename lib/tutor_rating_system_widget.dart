import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'custom_alert_dialog.dart';
import 'data_model/tutor_rating_review_data_model.dart';
import 'repository/review_repository.dart';
import 'repository/tutee_repository.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

int numberOfReviews = 0;

class CustomList {
  final String reviewer;
  final String review;
  final double rating;
  final String dateTime;

  const CustomList(
    this.reviewer,
    this.review,
    this.rating,
    this.dateTime,
  );
}

class TutorReviewPage extends StatefulWidget {
  final String tutorID;
  final String name;
  final String description;
  final double averageRating;
  const TutorReviewPage(
      {super.key,
      required this.tutorID,
      required this.name,
      required this.description,
      required this.averageRating});

  @override
  State<TutorReviewPage> createState() => TutorReviewPageState();
}

class TutorReviewPageState extends State<TutorReviewPage> {
  TextEditingController textController = TextEditingController();
  String tuteeID = "1";
  List<ReviewRating> reviews = [];
  List<CustomList> listToShow = [];
  double rating = 0.0;
  String review = "";
  double newAverageRating = 0.0;//Record the new average rating when a user submit a review.
  bool listIsLoading = false;

  void loadList() async {
    setState(() {
      listIsLoading = true;
    });
    List<String> tuteeIDs = [];
    try {
      reviews =
          await ReviewRepository().getReviewRatingforATutor(widget.tutorID);
      for (var review in reviews) {
        tuteeIDs.add(review.tuteeID);
      }

      List<String> tuteeNames = await TuteeRepository().getTuteeName(tuteeIDs);
      List<CustomList> temp = [];
      for (int i = 0; i < tuteeIDs.length; i++) {
        temp.add(CustomList(tuteeNames[i], reviews[i].review, reviews[i].rating,
            reviews[i].datetime));
      }
      setState(() {
        listToShow = temp;
        numberOfReviews = listToShow.length;
        listIsLoading = false;
      });
    } catch (e) {
      setState(() {
        listIsLoading = false;
      });
      if (!mounted) return;
      CustomAlertDialog().showAlertMessage(
        context,
        title: "Connection to firestore failed",
        body: "Fail to retrieve reviews. Please try again.",
      );
    }
  }

  void sendReview(
      BuildContext context, String name, String review, double rating) {
    if (review.isEmpty || rating.isNaN) {
      CustomAlertDialog().showAlertMessage(
        context,
        title: 'Error when sending review',
        body: 'Review and rating is empty.',
      );
      return;
    }

    try {
      DateTime currentTime = DateTime.now();
      var formattedCurrentTime =
          DateFormat("dd-MM-yyyy HH:mm").format(currentTime);

      updateFirestore(name, currentTime, formattedCurrentTime);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              icon: const Icon(Icons.check_circle),
              title: const Text("Success"),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text("Review is submitted successfully."),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ok'),
                ),
              ],
            );
          });
      setState(() {
        listIsLoading = false;
      });
    } catch (e) {
      CustomAlertDialog().showAlertMessage(
        context,
        title: 'Error when sending review',
        body: 'Something went wrong. Please try again later.',
      );
    }
  }

  //Calculate the updated average rating.
  double calculateAverageRating(double rating, double currentAverageRating, int numberOfReviews) {
    double totalRatings = (currentAverageRating * numberOfReviews) + rating;
    numberOfReviews = numberOfReviews + 1;
    double averageRating = totalRatings / numberOfReviews;
    averageRating = (averageRating * 100).round() / 100;

    return averageRating;
  }

  void updateFirestore(String name, DateTime currentTime, var formattedCurrentTime) async {
    Timestamp timestamp = Timestamp.fromDate(currentTime);
    try {
      double avgRating = 0.0;
      //Upload review to firestore.
      CollectionReference tutorCollection = FirebaseFirestore.instance.collection("Users");
      DocumentSnapshot documentSnapshot = await tutorCollection.doc(widget.tutorID).get();

      if (documentSnapshot.exists)
      {
        final docToUpdate = tutorCollection.doc(widget.tutorID);
        avgRating =  calculateAverageRating(rating, widget.averageRating, numberOfReviews);
        docToUpdate.update({'averageRating': avgRating});

        //Add a new document with the new review details.
        CollectionReference savedTutorCollection = docToUpdate.collection("ReviewRating");
        await savedTutorCollection.add({
          "tuteeID": tuteeID,
          "review": review,
          "rating": rating,
          "dateTime": timestamp
        });
      }
      setState(() {
        newAverageRating = avgRating;
        listToShow.insert(0, CustomList("tuteeName", review, rating, formattedCurrentTime));
      });

      // CollectionReference tutorCollection =FirebaseFirestore.instance.collection("Tutor");
      // QuerySnapshot querySnapshot = await tutorCollection.where('tutorID', isEqualTo: widget.tutorID).get();

      // if (querySnapshot.docs.isNotEmpty) {
      //   for (var document in querySnapshot.docs) {
      //     //Update the average rating for a tutor.
      //     final docToUpdate = tutorCollection.doc(document.reference.id);
      //     avgRating = calculateAverageRating();
      //     docToUpdate.update({'averageRating': avgRating});

      //     //Add a new document with the new review details.
      //     CollectionReference savedTutorCollection = tutorCollection
      //         .doc(document.reference.id)
      //         .collection("ReviewRating");
      //     await savedTutorCollection.add({
      //       "tuteeID": tuteeID,
      //       "review": review,
      //       "rating": rating,
      //       "dateTime": timestamp
      //     });
      //   }
      //   setState(() {
      //     newAverageRating = avgRating;
      //     listToShow.insert(0, CustomList(name, review, rating, formattedCurrentTime));
      //   });
      // }
    } catch (e) {
      throw Exception("Fail to send review.");
    }
  }

  @override
  void initState() {
    try {
      loadList();
      newAverageRating = widget.averageRating;
    } catch (e) {
      CustomAlertDialog().showAlertMessage(
        context,
        title: "Connection to firestore failed",
        body: "Fail to retrieve reviews. Please try again.",
      );
    }

    super.initState();
    newAverageRating = widget.averageRating;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, newAverageRating);
          },
          icon: const BackButtonIcon(),
          color: Colors.white,
        ),
        title: const Center(
            child: Text(
          "Tutor Reviews",
          style: TextStyle(fontSize: 40, color: Colors.white),
        )),
        backgroundColor: const Color.fromARGB(255, 52, 128, 244),
      ),
      body: Column(children: [
        const Padding(padding: EdgeInsets.only(top: 20.0),),
        Center(child: Text("Tutor Name: ${widget.name}")),
        Center(child: Text("Tutor Description: ${widget.description}")),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("$newAverageRating", style: const TextStyle(fontSize: 50),),
            RatingBarIndicator(
              rating: newAverageRating,
              itemSize: 50.0,
              itemBuilder: (_, __) => const Icon(Icons.star, color: Colors.yellow),
            ),
          ]
        ),
        const SizedBox(height: 20),
        const Text("Send a review:"),
        RatingBar.builder(
          initialRating: 0,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemPadding: const EdgeInsets.all(10),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.yellow,
          ),
          onRatingUpdate: (rating) {
            this.rating = rating;
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: TextField(
          onChanged: (review) => this.review = review,
          controller: textController,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Review',
              hintStyle: TextStyle(color: Color.fromARGB(255, 151, 148, 148))
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: () {
              sendReview(context, "bob", review, rating); //Replace name with tutee's name.
            },
            child: const Text('Send'),
          ),
        ),
        listIsLoading
          ? const CircularProgressIndicator()
          : listToShow.isEmpty
            ? const Center(child: Text("No reviews."))
            :Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                itemCount: listToShow.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: const Color.fromARGB(255, 194, 193, 193),
                    child: ListTile(
                      title: RatingBarIndicator(
                        rating: listToShow[index].rating,
                        itemSize: 20.0,
                        itemBuilder: (_, __) =>
                            const Icon(Icons.star, color: Colors.yellow),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            listToShow[index].reviewer,
                            style: const TextStyle(fontSize: 10.0),
                          ),
                          Text(
                            listToShow[index].dateTime,
                            style: const TextStyle(fontSize: 10.0),
                          ),
                          Text(listToShow[index].review),
                          const Padding(padding: EdgeInsets.only(bottom: 20.0)),
                          Container(color: Colors.white, height: 10.0, width: double.infinity,)
                        ],
                      ),
                    ),
                  );
                }
              ),
            ),
      ]),
    );
  }
}
