import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/login/login_service.dart';
import '../../services/userpreferences_service.dart';
import '../../views/home/home_screen.dart';
import '../../views/login/login_screen.dart';

class LoginViewModel extends GetxController {
  final LoginService loginService;
  var isLoading = false.obs;
  var loginError = Rxn<String>();
  var authToken = Rxn<String>();

  // FocusNode와 포커스 상태 관리
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  var isEmailFocused = false.obs;
  var isPasswordFocused = false.obs;
  var passwordVisible = false.obs;
  var email = ''.obs;
  var password = ''.obs;

  LoginViewModel(this.loginService) {
    // 포커스 노드 리스너 설정
    emailFocusNode.addListener(() {
      isEmailFocused.value = emailFocusNode.hasFocus;
    });
    passwordFocusNode.addListener(() {
      isPasswordFocused.value = passwordFocusNode.hasFocus;
    });
  }

  @override
  void onClose() {
    // 리소스 정리
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.onClose();
  }

  // 로그인을 시도하고 결과를 처리하는 메소드
  Future<bool> login() async {
    isLoading(true);
    try {
      // final response = await loginService.postLogin(email.value, password.value);
      // authToken.value = response.accessToken;
      // print('Login successful with token: ${authToken.value}');
      // await UserPreferences.setUserToken(response.accessToken);

      Get.toNamed('/home');

      return true;
    } catch (e) {
      loginError.value = e.toString();
      print('Login failed: $loginError');
      return false;
    } finally {
      isLoading(false);
    }
  }

  // 에러 메시지를 클리어하는 메소드
  void clearError() {
    loginError.value = null;
  }

  // 로그인 상태 확인 (예: 토큰의 존재 유무)
  bool isUserLoggedIn() {
    return authToken.value != null && authToken.value!.isNotEmpty;
  }
}
