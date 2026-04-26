import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final ListBloc bloc;

  @override
  void initState() {
    bloc = ListBloc(RepoList())..add(LoadList());
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        cardTheme: CardThemeData(margin: .zero),
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider.value(value: bloc, child: MyHomePage()),
    );
  }
}

class RepoList {
  List<String> getItem() {
    return ["Reliance Industries", "TCS", "HDFC Bank", "Infosys"];
  }
}

abstract class ListState {}

class InitList extends ListState {}

class LoadedList extends ListState {
  final List<String> list;

  LoadedList(this.list);
}

abstract class ListEvent {}

class LoadList extends ListEvent {
  LoadList();
}

class ReorderList extends ListEvent {
  final List<String> list;

  ReorderList(this.list);
}

class ListBloc extends Bloc<ListEvent, ListState> {
  final RepoList repo;
  ListBloc(this.repo) : super(InitList()) {
    on<LoadList>((event, emit) => emit(LoadedList(repo.getItem())));

    on<ReorderList>((event, emit) => emit(LoadedList(event.list)));
  }
}

abstract class ItemEvent {}

class ItemHold extends ItemEvent {}

abstract class ItemState {}

class Init extends ItemState {}

class Hold extends ItemState {}

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ItemBloc() : super(Init()) {
    on<ItemHold>((event, emit) async {
      emit(Hold()); // toggle value
      await Future.delayed(Duration(seconds: 1));
      emit(Init()); // toggle value
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ListBloc, ListState>(
        buildWhen: (pre, now) {
          if (pre is LoadedList && now is LoadedList) return false;
          return true;
        },
        builder: (context, state) {
          switch (state) {
            case InitList():
              return Center(
                child: SizedBox.square(
                  dimension: 400,
                  child: CircularProgressIndicator(),
                ),
              );
            case LoadedList(:final list):
              final mutList = [...list];
              return ReorderableListView.builder(
                buildDefaultDragHandles: false,
                onReorder: (oldIndex, newIndex) {
                  if (oldIndex < newIndex) newIndex -= 1;
                  final item = mutList.removeAt(oldIndex);
                  mutList.insert(newIndex, item);
                  context.read<ListBloc>().add(ReorderList(mutList));
                },
                itemCount: mutList.length,

                itemBuilder: (context, index) {
                  return ReorderableDelayedDragStartListener(
                    key: ValueKey(mutList[index]),
                    index: index,
                    child: ItemWidget(mutList[index]),
                  );
                },
              );
            case ListState():
              return throw UnimplementedError();
          }
        },
      ),
    );
  }
}

class ItemWidget extends StatefulWidget {
  const ItemWidget(this.item, {super.key});

  final String item;

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  late final ItemBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ItemBloc();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 21 / 4,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(alignment: .centerLeft, child: Text(widget.item)),
        ),
      ),
    );
  }
}
