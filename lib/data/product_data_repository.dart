import 'package:heady_assignement/models/all_product_data_model.dart';

abstract class ProductDataRepository {
  Future<AllProductDataModel> fetchAllProductData();
}