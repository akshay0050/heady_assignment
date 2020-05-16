import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'package:heady_assignement/data/fetch_product_data.dart';
import 'package:heady_assignement/data/product_data_repository.dart';
import 'package:heady_assignement/database/dao/product_category_dao.dart';
import 'package:heady_assignement/database/dao/product_info_dao.dart';
import 'package:heady_assignement/models/all_product_data_model.dart';
import 'package:heady_assignement/models/product_category_model.dart';
import 'package:heady_assignement/models/product_info_model.dart';
import 'package:heady_assignement/utility/utils.dart';

import 'bloc.dart';

class ProductDataBloc extends Bloc<ProductDataEvent, ProductDataState> {
  final ProductDataRepository repository;

  ProductDataBloc(this.repository);
  @override
  ProductDataState get initialState => ProductDataInitial();

  @override
  Stream<ProductDataState> mapEventToState(ProductDataEvent event,) async*{
    yield ProductDataLoading();

    if(event is GetAllProductData) {
      bool isInternetAvailable= await Utils.isInternetConnectionAvailable();
     if(isInternetAvailable) {
       try {
         final allProductData = await repository.fetchAllProductData();
         int insertCount = await insertProductInfo(allProductData);
         yield ProductDataLoaded(allProductData);
       } on NetworkError {
         yield ProductDataError("Network Error");
       }
     } else {
       yield NoInternetError();
     }
    }
  }

  Future<int> insertProductInfo(AllProductDataModel allProductDataModel) async {
    List<ProductInfoModel> productInfoModelList = new List<ProductInfoModel>();
    List<ProductCategoryModel> productCategoryModelList = new List<ProductCategoryModel>();
    List<Categories> categoriesList = allProductDataModel.categories;
    for(var productCategory in categoriesList) {
      ProductCategoryModel categoryModel = ProductCategoryModel();
      categoryModel.categoryId= productCategory.id;
      categoryModel.categoryName = productCategory.name;
      categoryModel.categoryJson = json.encode(productCategory.toJson());
      productCategoryModelList.add(categoryModel);
      for(var productObj in productCategory.products){
        ProductInfoModel infoModel = ProductInfoModel();
        infoModel.categoryName = productCategory.name;
        infoModel.productId = productObj.id;
        infoModel.productJson = json.encode(productObj.toJson());
        productInfoModelList.add(infoModel);
      }

    }
    List<dynamic> log = await ProductInfoDao.insertProductInfo(productInfoModelList);
    List<dynamic> categoryLog = await ProductCategoryDao.insertProductCategory(productCategoryModelList);

    return log.length;
  }
}