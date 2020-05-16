import 'dart:convert';

import 'package:heady_assignement/data/product_data_repository.dart';
import 'package:heady_assignement/models/all_product_data_model.dart';
import 'package:heady_assignement/network_calls/api_services.dart';
import 'package:heady_assignement/network_calls/env.dart';

class FetchProductData implements ProductDataRepository {
  @override
  Future<AllProductDataModel> fetchAllProductData() async {
    // TODO: implement fetchAllProductData

    final apiServiceObj = ApiService.create(Env.BASE_URL);
    var res;
    try {
      print("api calling");
      res = await apiServiceObj.getAlProductData();
      if (res != null && res.body != null && res.statusCode == 200) {
        var allProductDataObj = res.body;
        print("api response ${res.body}");
        AllProductDataModel allProductDataModel = AllProductDataModel.fromJson(allProductDataObj);
        if(allProductDataModel != null) {
        return allProductDataModel;
        } else {
        throw NetworkError();
        }
      } else {
        throw NetworkError();
      }
    } on Exception catch (e) {
      throw NetworkError();
    } catch (error) {
      throw NetworkError();
    }
  }

}

class NetworkError extends Error {}