import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'math_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final mathBloc = MathBloc();
  final TextEditingController number1 = TextEditingController();
  final TextEditingController number2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: number1,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter First Number',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: number2,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter First Number',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], // Only numbers can be entered
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  mathBloc.calcBloc(
                      int.parse(number1.text), int.parse(number2.text));
                  mathBloc.eventSink.add(calc.add);
                },
                child: const Text('Add'),
              ),
              ElevatedButton(
                onPressed: () {
                  mathBloc.calcBloc(
                      int.parse(number1.text), int.parse(number2.text));
                  mathBloc.eventSink.add(calc.sub);
                },
                child: const Text('Substract'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  mathBloc.calcBloc(
                      int.parse(number1.text), int.parse(number2.text));
                  mathBloc.eventSink.add(calc.mul);
                },
                child: const Text('Multiply'),
              ),
              ElevatedButton(
                onPressed: () {
                  mathBloc.calcBloc(
                      int.parse(number1.text), int.parse(number2.text));
                  mathBloc.eventSink.add(calc.div);
                },
                child: const Text('Divide'),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Center(
            child: StreamBuilder(
                stream: mathBloc.mathStream,
                initialData: 0,
                builder: (context, snapshot) {
                  return Text(
                    'Result is: ${snapshot.data}',
                    style: const TextStyle(fontSize: 25),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
