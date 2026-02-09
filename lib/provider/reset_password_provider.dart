import 'package:flutter/widgets.dart';

class ResetPasswordProvider extends ChangeNotifier{


   bool _isNewPassword = true;
  bool get isNewPassword => _isNewPassword;
  void toggleNewPassword() {
    _isNewPassword = !_isNewPassword;
    notifyListeners();
  }


   bool _isConfirmPassword = true;
  bool get isConfirmPassword => _isConfirmPassword;
  void toggleConfirmPassword() {
    _isConfirmPassword = !_isConfirmPassword;
    notifyListeners();
  }
} 