import 'dart:async';
import 'dart:math' show Random;


void main() {   /// [_2 -> 6NumbersSum]
  final calc = MentalCalc(6);   /// [main() -> MentalCalc()]
  Output(calc);   /// [main() -> Output()]

  final timer = Timer.periodic(   // 1秒ごとに経過秒数を投げる
    Duration(seconds: 1),
    (Timer t) {
      calc.add(t.tick);
    },
  );

  calc.onStop.listen((_) {   // 停止の連絡でタイマーを止める
    timer.cancel();
  });
}



/// [main() -> MentalCalc()]
class MentalCalc {
  final _calcController = StreamController<int>();   /// [StreamControllerからcontroller]define
  final _outputController = StreamController<String>();   /// [StreamControllerからcontroller]define
  final _stopController = StreamController<void>();   /// [StreamControllerからcontroller]define


  Function(int) get add => _calcController.sink.add;  /// [controller.sink.add()]に入力するメソッドのGetter
  Stream<String> get onAdd => _outputController.stream;  /// [controller.stream]へ出力するGetter
  Stream<void> get onStop => _stopController.stream;  /// [controller.stream]へ出力するGetter

  int _sum = 0;

  MentalCalc(int repeat) {   /// repeat回数6、引数、_sum=0へ加算していく  [MentalCalc()クラスがBLoCに相当]
    _calcController.stream.listen(   /// [controller.stream.listen()]
      (count) {
        if (count < repeat + 1) {
          var num = Random().nextInt(99) + 1;  // Random範囲0-100にする為+1
          _outputController.sink.add('$num');   /// [controller.sink.add()]
          _sum += num;

        } else {
          _outputController.sink.add('答えは$_sum');   /// [controller.sink.add()]
          _stopController.sink.add(null);   /// [controller.sink.add()]
        }
      },
    );
  }
}



/// [main() -> Output()]
class Output {
  Output(MentalCalc calc) {
    calc.onAdd.listen(   // 値が来たらそのまま出力
      (value) {
        print(value);
      },
    );
  }
}