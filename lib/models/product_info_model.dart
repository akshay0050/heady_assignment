class ProductInfoModel {
  int _iId;
  int _productId;
  String _categoryName;
  String _productJson;

  ProductInfoModel(
      {int iId, int productId, String categoryName, String productJson}) {
    this._iId = iId;
    this._productId = productId;
    this._categoryName = categoryName;
    this._productJson = productJson;
  }

  int get iId => _iId;
  set iId(int iId) => _iId = iId;
  int get productId => _productId;
  set productId(int productId) => _productId = productId;
  String get categoryName => _categoryName;
  set categoryName(String categoryName) => _categoryName = categoryName;
  String get productJson => _productJson;
  set productJson(String productJson) => _productJson = productJson;

  ProductInfoModel.fromJson(Map<String, dynamic> json) {
    _iId = json['_id'];
    _productId = json['productId'];
    _categoryName = json['categoryName'];
    _productJson = json['productJson'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this._iId;
    data['productId'] = this._productId;
    data['categoryName'] = this._categoryName;
    data['productJson'] = this._productJson;
    return data;
  }
}
