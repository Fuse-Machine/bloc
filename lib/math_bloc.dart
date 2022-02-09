import 'dart:async';

enum calc {
  add,
  sub,
  mul,
  div,
}

class MathBloc {
  int result = 0;

  final _stateStreamController = StreamController<int>();
  StreamSink<int> get _mathSink => _stateStreamController.sink;
  Stream<int> get mathStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<calc>.broadcast();
  StreamSink<calc> get eventSink => _eventStreamController.sink;
  Stream<calc> get _eventStream => _eventStreamController.stream;

  calcBloc(int n1, int n2) {
    _eventStream.listen((event) {
      if (event == calc.add) {
        result = n1 + n2;
      }
      if (event == calc.sub) {
        result = n1 - n2;
      }
      if (event == calc.mul) {
        result = n1 * n2;
      }
      if (event == calc.div) {
        result = (n1 ~/ n2);
      }
      _mathSink.add(result);
    });
  }
}
