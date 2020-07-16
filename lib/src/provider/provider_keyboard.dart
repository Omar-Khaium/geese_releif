import 'package:flutter/cupertino.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class KeyboardProvider extends ChangeNotifier {
  bool isKeyboardVisible = false;

  init() {
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        isKeyboardVisible = visible;
        notifyListeners();
      },
    );
  }

  hideKeyboard(BuildContext context) {
    if(isKeyboardVisible)
      FocusScope.of(context).requestFocus(FocusNode());
  }
}
