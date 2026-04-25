import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
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
      home: MyHomePage(),
    );
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
  // BlocProvider(create: (_) => ItemBloc(), child: const MyApp())
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 2,

        itemBuilder: (context, index) {
          return BlocProvider(
            create: (_) => ItemBloc(),
            child: BlocBuilder<ItemBloc, ItemState>(
              builder: (BuildContext context, ItemState state) {
                return GestureDetector(
                  onLongPress: () {
                    context.read<ItemBloc>().add(ItemHold());
                  },
                  child: switch (state) {
                    Hold() => SizedBox.square(
                      dimension: 400,
                      child: Container(
                        color: Colors.black,
                        child: Center(child: Text("Hello World")),
                      ),
                    ),
                    Init() => SizedBox.square(
                      dimension: 400,
                      child: Container(
                        color: Colors.grey,
                        child: Center(child: Text("Hello World")),
                      ),
                    ),
                    ItemState() => throw UnimplementedError(),
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
