import 'dart:async';

class MyModel {
  int _secondCount = 0;
  int _thirdCount = 0;
  int _value = 0;
  final StreamController<int> _secondCountController = StreamController();
  Stream<int> get secondCountStream => _secondCountController.stream;
  final StreamController<int> _thirdCountController = StreamController();
  Stream<int> get thirdCountStream => _thirdCountController.stream;
  final StreamController<int> _valueController = StreamController();
  Stream<int> get valueStream => _valueController.stream;

  void updateSecond() {
    _secondCountController.sink.add(_secondCount++);
  }

  void updateThird() {
    _thirdCountController.sink.add(_thirdCount++);
  }

  void changeValue() {
    _valueController.sink.add(_value++);
  }

  void dispose() {
    _secondCountController.close();
    _thirdCountController.close();
    _valueController.close();
  }
}