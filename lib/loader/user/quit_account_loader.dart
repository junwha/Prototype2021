import 'package:prototype2021/model/signin/http/quit_account.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/utils/logger/logger.dart';
import 'package:prototype2021/utils/safe_http/base.dart';
import 'package:prototype2021/utils/safe_http/safe_http.dart';

class QuitAccountLoader {
  // Custom Functions

  Future<void> quitAccount(String? token) async {
    QuitAccountInput params = new QuitAccountInput();
    SafeQueryInput<QuitAccountInput> dto = new SafeQueryInput(
      url: quitAccountUrl,
      params: params,
      token: token,
    );
    await safeDELETE<QuitAccountInput, QuitAccountOutput>(dto);
  }

  // Endpoints

  String quitAccountUrl = "$apiBaseUrl/user/";
}
