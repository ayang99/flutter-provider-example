// EventProvider (Stream)
class EventProvider {
  Stream<int> intStream() {
    Duration interval = Duration(seconds: 2);
    int _count = 0;
    return Stream<int>.periodic(interval, (int _count) => _count++);
  }
}
