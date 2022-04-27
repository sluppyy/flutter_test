extension Map<T> on List<T> {
  List<R> map<R>(R Function(T) mapper) {
    final List<R> result = [];

    for (T value in this) {
      result.add(mapper(value));
    }

    return result;
  }
}