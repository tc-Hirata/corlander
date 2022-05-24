import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier {
  String kboyText = 'KBOY';

  void chngeKboyText(){
    kboyText = 'kboyさんかっこいい!!!!!';
    //変更したことを通知する
    notifyListeners();
  }
}