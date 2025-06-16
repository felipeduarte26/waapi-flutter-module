/// This interface describes all the methods needed to rating app in store
abstract class RatingService<T> {
  Future<void> ratingAction();
  T get instance;
}
