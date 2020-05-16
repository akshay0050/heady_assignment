import 'package:equatable/equatable.dart';
import 'package:heady_assignement/models/all_product_data_model.dart';

abstract class ProductDataState extends Equatable {
  const ProductDataState();
}

class ProductDataInitial extends ProductDataState {
  const ProductDataInitial();
  @override
  List<Object> get props => [];
}

class ProductDataLoading  extends ProductDataState {
  const ProductDataLoading();

  @override
  List<Object> get props => [];
}

class ProductDataLoaded extends ProductDataState {
  final AllProductDataModel allProductData;
  const ProductDataLoaded(this.allProductData);
  @override
  List<Object> get props => [allProductData];
}

class ProductDataError extends ProductDataState {
  final String message;
  const ProductDataError(this.message);
  @override
  List<Object> get props => [message];
}

class NoInternetError extends ProductDataState {
  const NoInternetError();
  @override
  List<Object> get props => [];
}

