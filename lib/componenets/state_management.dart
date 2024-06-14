import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  double amount = 3.0;
  String mainText = "WILDCAT LOUNGE";
  String subText = '"to WILDCAT LOUNGE"';
  String bubbleText = "WL";
  String sendText = "wildcat-15";

  void updateAmount(double newAmount) {
    amount = newAmount;
    notifyListeners();
  }

  void updateMainText(String newText) {
    mainText = newText;
    notifyListeners();
  }

  void updateSubText(String newText) {
    subText = newText;
    notifyListeners();
  }

  void updateBubbleText(String newText) {
    bubbleText = newText;
    notifyListeners();
  }

  void updateSendText(String newText) {
    sendText = newText;
    notifyListeners();
  }
}
