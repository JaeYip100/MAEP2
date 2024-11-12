import 'package:flutter_test/flutter_test.dart';
import 'package:mae_assignment/tutor_review_page.dart';

void main() {
  test("Calculate new average rating", ()
  {
    const reviewWidget = TutorReviewPage(tutorID: "1", name: "bob", description: "i dont know", averageRating: 1.0);
    final reviewWidgetState = reviewWidget.createState() as TutorReviewPageState;
    reviewWidgetState.initState();
    reviewWidgetState.rating = 5.0;
    expect(reviewWidget.averageRating, 1.0);
    reviewWidgetState.calculateAverageRating();
    double initialAverageRating = 0.0;
    double averageRating = calculateAverageRating();
  });
}