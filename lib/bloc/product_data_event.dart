import 'package:equatable/equatable.dart';
import 'package:heady_assignement/models/all_product_data_model.dart';

abstract class ProductDataEvent extends Equatable {
  const ProductDataEvent();
}

class GetAllProductData extends ProductDataEvent {

  const GetAllProductData();

  @override
  List<Object> get props => [];

}