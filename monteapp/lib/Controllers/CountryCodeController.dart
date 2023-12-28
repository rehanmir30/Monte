import 'package:get/get.dart';

import '../Models/CountryCode.dart';

class CountryCodeController extends GetxController{

  List<CountryCode>_countryCodeList=[];
  CountryCode? _selectedCountryCode;
  CountryCode? get selectedCountryCode=>_selectedCountryCode;
  List<CountryCode>get countryCodeList=>_countryCodeList;

  setSelectedCountry(CountryCode selected){
    _selectedCountryCode=selected;
    update();
  }
  addCountryCode(CountryCode _countryCode){
    _countryCodeList.add(_countryCode);
    update();
  }

}