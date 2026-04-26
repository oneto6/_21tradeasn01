import 'package:_21tradeasn01/core/model/stock.dart';

abstract class WatchlistState {}

class WatchlistInit extends WatchlistState {}

class WatchlistLoaded extends WatchlistState {
  final List<Stock> list;

  WatchlistLoaded(this.list);
}
