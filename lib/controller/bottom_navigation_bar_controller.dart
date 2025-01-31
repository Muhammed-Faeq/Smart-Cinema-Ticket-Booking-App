import 'package:get/get.dart';

class BTNController extends GetxController {
  var tabIndex = 0;
  changeTabIndex(int index) {
    tabIndex = index;
    update();
  }
}
