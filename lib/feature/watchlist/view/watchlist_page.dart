import 'package:_21tradeasn01/core/widgets/stock_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:_21tradeasn01/feature/watchlist/bloc/watchlist_bloc.dart';
import 'package:_21tradeasn01/feature/watchlist/bloc/watchlist_event.dart';
import 'package:_21tradeasn01/feature/watchlist/bloc/watchlist_state.dart';
import 'package:_21tradeasn01/feature/watchlist/repo/repo.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  late final WatchlistBloc bloc;

  @override
  void initState() {
    bloc = WatchlistBloc(WatchlistRepo())..add(WatchlistLoad());
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: BlocProvider(
          create: (_) => bloc,
          child: BlocBuilder<WatchlistBloc, WatchlistState>(
            buildWhen: (pre, now) {
              if (pre is WatchlistLoaded && now is WatchlistLoaded) {
                return false;
              }
              return true;
            },
            builder: (context, state) {
              switch (state) {
                case WatchlistInit():
                  return Center(
                    child: SizedBox.square(
                      dimension: 40,
                      child: CircularProgressIndicator(),
                    ),
                  );
                case WatchlistLoaded(:final list):
                  final mutlist = [...list];
                  return ReorderableListView.builder(
                    proxyDecorator: (child, index, _) {
                      return child;
                    },
                    buildDefaultDragHandles: false,
                    onReorder: (oldIndex, newIndex) {
                      if (oldIndex < newIndex) newIndex -= 1;
                      final item = mutlist.removeAt(oldIndex);
                      mutlist.insert(newIndex, item);
                      context.read<WatchlistBloc>().add(
                        WatchlistReorder(mutlist),
                      );
                    },
                    itemCount: mutlist.length,

                    itemBuilder: (context, index) {
                      return ReorderableDelayedDragStartListener(
                        key: ValueKey(mutlist[index].id),
                        index: index,
                        child: StockCard(mutlist[index]),
                      );
                    },
                  );
                case WatchlistState():
                  return throw UnimplementedError();
              }
            },
          ),
        ),
      ),
    );
  }
}
