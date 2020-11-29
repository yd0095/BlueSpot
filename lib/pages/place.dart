class Place2 {
  final String name;
  final bool isClosed;

  const Place2({this.name, this.isClosed = false});

  @override
  String toString() {
    // TODO: implement toString
    return 'Place $name (closed : $isClosed)';
  }
}
