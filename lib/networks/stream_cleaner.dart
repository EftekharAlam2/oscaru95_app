import 'package:oscaru95/helpers/di.dart';

import '../constants/app_constants.dart';

Future<void> totalDataClean() async {
  await appData.write(kKeyIsLoggedIn, false);
  // await appData.write(kKeyRole, '');
}
