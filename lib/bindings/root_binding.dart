import 'package:get/get.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    // ParentViewModel is singleton
    // Get.put(RootViewModel());
    // Get.lazyPut(() => HomeViewModel());
    // Get.lazyPut(() => ChatViewModel());
    // Get.lazyPut(() => LikeViewModel());
    // Get.lazyPut(() => MyViewModel());
    // Get.lazyPut(() => DogInfoViewModel(),fenix: true);
    // Get.lazyPut(() => PostController(),fenix: true);
    // Get.put(LoginViewModel());
    //
    // //DogInfoViewModel를 최대한 빨리 생성하기위한 코드
    //
    // Get.lazyPut(() => MessageViewModel());
  }
}
