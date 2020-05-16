class ProductCategoryModel {
  int _iId;
  int _categoryId;
  String _categoryName;
  String _categoryJson;

  ProductCategoryModel(
      {int iId, int categoryId, String categoryName, String categoryJson}) {
    this._iId = iId;
    this._categoryId = categoryId;
    this._categoryName = categoryName;
    this._categoryJson = categoryJson;
  }

  int get iId => _iId;
  set iId(int iId) => _iId = iId;
  int get categoryId => _categoryId;
  set categoryId(int categoryId) => _categoryId = categoryId;
  String get categoryName => _categoryName;
  set categoryName(String categoryName) => _categoryName = categoryName;
  String get categoryJson => _categoryJson;
  set categoryJson(String categoryJson) => _categoryJson = categoryJson;

  ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    _iId = json['_id'];
    _categoryId = json['categoryId'];
    _categoryName = json['categoryName'];
    _categoryJson = json['categoryJson'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this._iId;
    data['categoryId'] = this._categoryId;
    data['categoryName'] = this._categoryName;
    data['categoryJson'] = this._categoryJson;
    return data;
  }
}
