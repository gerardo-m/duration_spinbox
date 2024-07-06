import 'package:flutter/material.dart';
import 'package:duration_spinbox/duration_spinbox.dart';

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
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Duration Spinbox Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Duration _duration = const Duration(minutes: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Default (min=Duration.zero, no state)'),
            const DurationSpinbox(
              value: Duration(minutes: 1),
            ),
            const Divider(),
            const Text('With state'),
            DurationSpinbox(
              value: _duration,
              onChanged: (value) {
                setState(() {
                  _duration = value;
                });
              },
            ),
            const Divider(),
            const Text('With min and max'),
            const DurationSpinbox(
              value: Duration(minutes: 1),
              min: Duration(minutes: 1),
              max: Duration(minutes: 5),
            ),
            const Divider(),
            const Text('No bounds, step value of 5 minutes'),
            const DurationSpinbox(
              value: Duration(minutes: 0),
              min: null,
              stepValue: Duration(minutes: 5),
            ),
            const Divider(),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
