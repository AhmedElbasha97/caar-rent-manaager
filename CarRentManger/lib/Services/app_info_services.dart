
import 'package:carrentmanger/Models/terms_and_privacy_model.dart';
import 'package:carrentmanger/Utils/api_service.dart';
import 'package:carrentmanger/Utils/services.dart';
import 'package:carrentmanger/models/app_department_model.dart';
import 'package:carrentmanger/models/country_code_model.dart';
import 'package:carrentmanger/models/category_model.dart';
import 'package:carrentmanger/models/social_link_model.dart';

class AppInfoServices{
  static ApiService api = ApiService();
  static Future<List<CountryCodeModel>?>getCountriesCodesList() async {
    List<CountryCodeModel>? countriesCodesList = [];
    var data = await api.request(Services.countriesCodesEndPoint, "POST",queryParamters: {
    });
    if (data != null) {
      for(var countryCodeData  in data){
        countriesCodesList.add(CountryCodeModel.fromJson(countryCodeData));
      }
      return countriesCodesList;
    }
    return null;
  }
  static Future<List<CategoryModel>?>getCityList(String countryId) async {
    List<CategoryModel>? cityList = [];
    var data = await api.request(Services.citiesEndPoint, "POST",queryParamters: {
      "country_id":countryId
    });
    if (data != null) {
      for(var cityData  in data){
        cityList.add(CategoryModel.fromJson(cityData));
      }
      return cityList;
    }
    return null;
  }
  static Future<TermsAndPrivacyModel?>getTermsAndConditions() async {

    var data = await api.request(Services.getTermsAndConditionsEndPoint, "POST");
    if (data != null) {
      return TermsAndPrivacyModel.fromJson(data[0]);
    }
    return null;
  }
  static Future<TermsAndPrivacyModel?>getPrivacyPolicy() async {

    var data = await api.request(Services.getPrivacyPolicyEndPoint, "POST");
    if (data != null) {
      return TermsAndPrivacyModel.fromJson(data[0]);
    }
    return null;
  }
  static Future<SocialLinkModel?>getSocialLink() async {
    var data = await api.request(Services.getSocialLinkModelEndPoint, "POST",queryParamters: {
    });
    if (data != null) {

      return SocialLinkModel.fromJson(data[0]);
    }
    return null;
  }
  static Future<AppDepartmentModel?>getAppDepartment() async {
    var data = await api.request(Services.getAppDepartmentEndPoint, "POST",queryParamters: {
    });
    if (data != null) {

      return AppDepartmentModel.fromJson(data[0]);
    }
    return null;
  }

}