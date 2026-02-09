/* import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../constants/app_constants.dart';
import '../../../../helpers/di.dart';
import '../../../../networks/dio/dio.dart';
import '../../../../networks/rx_base.dart';
import 'api.dart';

final class PostSignUpRX extends RxResponseInt {
  final api = SignUpApi.instance;

  PostSignUpRX({required super.empty, required super.dataFetcher});

  ValueStream get getPostSignUpRes => dataFetcher.stream;

  Future<bool> signupRx({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String agreeToTerms,
    required String role,
  }) async {
    try {
      Map data = await api.postSignUp(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        agreeToTerms: agreeToTerms,
        role: role,
      );
      return await handleSuccessWithReturn(data);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    // Extract data from response

    int? id = data['data']['user']['id'];
    String? name = data['data']['user']['name'];
    String? email = data['data']['user']['email'];
    String? role = data['data']['user']['role'];
    String? accesstoken = data['data']['user']['token'];

    await appData.write(kKeyId, id ?? -1);
    await appData.write(kKeyName, name ?? '');
    await appData.write(kEmail, email ?? '');
    await appData.write(kKeyUser, role ?? '');
    await appData.write(kKeyToken, accesstoken);
    await appData.write(kKeyIsLoggedIn, true);
    DioSingleton.instance.update(accesstoken!);

    dataFetcher.sink.add(data);
    return true;
  }

  @override
  handleErrorWithReturn(error) {
    String message = 'Something went wrong';
    if (error is DioException) {
      message = error.response?.data["message"] ?? "Something went wrong";
      if (error.type == DioExceptionType.connectionError) {
        message = "Check Your Network Connection";
      }
    }
    CustomToastMessage('Error', message);
    return false;
  }
} */