import 'dart:async';



void main() {   /// [_1 -> ichigo]
  final data = {'イチゴ':'苺', 'イチジク':'無花果'};

  final controller = StreamController<String>();


  /// [===== 入力 =====]
  controller.sink.add('イチゴ');   /// [controller.sink.add()]
  controller.sink.add('ドラゴンフルーツ');
  controller.sink.add('イチジク');

  ///  漢字変換 [出力(toKanji)より前に定義]
  final toKanji = StreamTransformer<String, String>.fromHandlers(
    handleData: (value, sink) {
      if (data.containsKey(value)) {
        sink.add(data[value]);
      } else {
        sink.addError('(漢字不明)${value}');
      }
    }
  );

  /// [===== 出力 =====]
  controller.stream
    .transform(toKanji)   /// [controller.stream.transform().listen()]
    .listen(
      (value) { print(value); },
      onError: (err) { print('error: $err'); }
    );

}