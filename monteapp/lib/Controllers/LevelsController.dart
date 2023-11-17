import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../Database/databasehelper.dart';
import '../Models/LevelModel.dart';

class LevelsController extends GetxController{

  List<LevelModel> _levelList=[];
  List<LevelModel> get levelList=>_levelList;


  @override
  onInit(){
    super.onInit();
    getLevels();
  }
  getLevels()async{
    _levelList=await DatabaseHelper().getAllLevels();
    update();
  }
}