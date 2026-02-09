import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isPassVisible = true;
  bool get isPassVisible => _isPassVisible;
  void togglePassword() {
    _isPassVisible = !_isPassVisible;
    notifyListeners();
  }

  bool _isRegisterPassVisible = true;
  bool get isRegisterPassVisible => _isRegisterPassVisible;
  void toggleRegisterPassVisiable() {
    _isRegisterPassVisible = !_isRegisterPassVisible;
    notifyListeners();
  }


  bool _isChecked = true;
  bool get isChecked => _isChecked;
  void toggleCheckBox() {
    _isChecked = !_isChecked;
    notifyListeners();
  }
  bool _isloginChecked = true;
  bool get isloginChecked => _isloginChecked;
  void toggleloginCheckBox() {
    _isloginChecked = !_isloginChecked;
    notifyListeners();
  }
  bool _newPassword = true;
  bool get newPassword => _newPassword;
  void toggleNewPassword() {
    _newPassword = !_newPassword;
    notifyListeners();
  }


  bool _isResetpass = true;
  bool get isResetpass => _isResetpass;
  void toggleResetPass() {
    _isResetpass = !_isResetpass;
    notifyListeners();
  }
  
  bool _restaurantcondition = true;
  bool get isOrderCheckBox => _restaurantcondition;
  void toggleRestaurantcondition() {
    _restaurantcondition = !_restaurantcondition;
    notifyListeners();
  }
  bool _isMyTableCondition = true;
  bool get isMyTableCondition => _isMyTableCondition;
  void toggleMytableCondition() {
    _isMyTableCondition = !_isMyTableCondition;
    notifyListeners();
  }




 
}
