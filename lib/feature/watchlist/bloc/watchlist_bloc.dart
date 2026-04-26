import 'package:_21tradeasn01/feature/watchlist/bloc/watchlist_event.dart';
import 'package:_21tradeasn01/feature/watchlist/bloc/watchlist_state.dart';
import 'package:_21tradeasn01/feature/watchlist/repo/repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final WatchlistRepo repo;
  WatchlistBloc(this.repo) : super(WatchlistInit()) {
    on<WatchlistLoad>((event, emit) async {
      await Future.delayed(Duration(milliseconds: 300));
      emit(WatchlistLoaded(repo.list()));
    });
    on<WatchlistReorder>((event, emit) => emit(WatchlistLoaded(event.list)));
  }
}
