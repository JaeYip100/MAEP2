import 'package:flutter_test/flutter_test.dart';
import 'package:mae_assignment/tutor_review_page.dart';

void main() {
  test("Calculate new average rating", ()
  {
    final reviewWidgetState = TutorReviewPageState();

    final newAverageRating = reviewWidgetState.calculateAverageRating(5.0, 3.0, 15);
    expect(newAverageRating, 3.13);
  });
}