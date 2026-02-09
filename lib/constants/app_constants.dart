// ignore_for_file: constant_identifier_names

final class AppRegExpText {
  AppRegExpText._();
// Regular Expression
  static String kRegExpEmail =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static String kRegExpPhone =
      // ignore: prefer_adjacent_string_concatenation
      "(\\+[0-9]+[\\- \\.]*)?(\\([0-9]+\\)[\\- \\.]*)?" +
          "([0-9][0-9\\- \\.]+[0-9])";

  static String patternMail =
      r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$";
}

const String kKeyAccessToken = "kKeyAccessToken";
const String kKeyRole = "kKeyRole";
const String kKeyUserFirstName = "kKeyUserFirstName";
const String kKeyUserLastName = "kKeyUserLastName";
const String kKeyIsLoggedIn = "kKeyIsLoggedIn";
const String kKeyDeviceID = "kKeyDeviceID";
const String kKeyFCMToken = "kKeyFCMToken";
const String KKeyUserId = "KKeyUserId";
const String kKeySelectedLat = "kKeySelectedLat";
const String kKeySelectedLng = "kKeySelectedLng";
const String kKeySelectedLocation = "kKeySelectedLocation";
