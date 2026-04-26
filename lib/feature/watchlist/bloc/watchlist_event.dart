import 'package:_21tradeasn01/core/model/stock.dart';

abstract class WatchlistEvent {}

class WatchlistLoad extends WatchlistEvent {}

class WatchlistReorder extends WatchlistEvent {
  final List<Stock> list;

  WatchlistReorder(this.list);
}
