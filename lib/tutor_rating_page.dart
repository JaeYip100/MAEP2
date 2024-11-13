// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'tutor_rating_provider.dart';

// class TutorRatingPage extends StatelessWidget {
  
//   const TutorRatingPage({super.key});
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Tutor Ratings'),
//         backgroundColor: Colors.blue,
//       ),
//       body: Center(
//         child: Consumer<TutorRatingProvider>(
//           builder: (context, ratingProvider, child) {
//             return const Text(
//               'Tutee rated you: 0 stars\nReview:',
//               style: TextStyle(fontSize: 20),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:provider/provider.dart';
// import 'tutor_rating_provider.dart';

// class TutorRatingPage extends StatelessWidget {
  
//   const TutorRatingPage({super.key});
  
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<TutorRatingProvider>(context);
//     provider.loadReviews();
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Tutor Ratings'),
//         backgroundColor: Colors.blue,
//       ),
//       body: Center(
//         child: Consumer<TutorRatingProvider>(
//           builder: (context, ratingProvider, child) {
//             final reviewRatings = ratingProvider.listToShow;
//             return Expanded(
//               child: ListView.builder(
//                 padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//                 itemCount: reviewRatings.length,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     color: const Color.fromARGB(255, 194, 193, 193),
//                     child: ListTile(
//                       title: RatingBarIndicator(
//                         rating: reviewRatings[index].rating,
//                         itemSize: 20.0,
//                         itemBuilder: (_, __) =>
//                             const Icon(Icons.star, color: Colors.yellow),
//                       ),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             reviewRatings[index].reviewer,
//                             style: const TextStyle(fontSize: 10.0),
//                           ),
//                           Text(
//                             reviewRatings[index].dateTime,
//                             style: const TextStyle(fontSize: 10.0),
//                           ),
//                           Text(reviewRatings[index].review),
//                           const Padding(padding: EdgeInsets.only(bottom: 20.0)),
//                           Container(color: Colors.white, height: 10.0, width: double.infinity,)
//                         ],
//                       ),
//                     ),
//                   );
//                 }
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'tutor_rating_provider.dart';

class TutorRatingPage extends StatelessWidget {
  
  const TutorRatingPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TutorRatingProvider>(context);
    provider.loadReviews();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutor Ratings'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Consumer<TutorRatingProvider>(
          builder: (context, ratingProvider, child) {
            final reviewRatings = ratingProvider.listToShow;
            return Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                itemCount: reviewRatings.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: const Color.fromARGB(255, 194, 193, 193),
                    child: ListTile(
                      title: RatingBarIndicator(
                        rating: reviewRatings[index].rating,
                        itemSize: 20.0,
                        itemBuilder: (_, __) =>
                            const Icon(Icons.star, color: Colors.yellow),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reviewRatings[index].reviewer,
                            style: const TextStyle(fontSize: 10.0),
                          ),
                          Text(
                            reviewRatings[index].dateTime,
                            style: const TextStyle(fontSize: 10.0),
                          ),
                          Text(reviewRatings[index].review),
                          const Padding(padding: EdgeInsets.only(bottom: 20.0)),
                          Container(color: Colors.white, height: 10.0, width: double.infinity,)
                        ],
                      ),
                    ),
                  );
                }
              ),
            );
          },
        ),
      ),
    );
  }
}