import 'package:get/get.dart';

import '../Models/MainCategoryModel.dart';

class MainCategoryController extends GetxController{
  List<MainCategoryModel> _mainCategoryList=[];
  List<MainCategoryModel>get mainCategoryList=>_mainCategoryList;

  addItemInMainCategoryList(MainCategoryModel _model){
    _mainCategoryList.add(_model);
    update();
  }
  clearCategoryList(){
    _mainCategoryList.clear();
  }

}