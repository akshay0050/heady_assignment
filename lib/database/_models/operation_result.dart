import 'dart:core';

class OperationResult {
  static const int OPERATION_FAILED = 0;
  static const int OPERATION_SUCCESSFUL = 1;
  String _message;
  int _result;

  OperationResult(var result) {
    this._message = message;
    this._result = result;
  }

  set message(String value) {
    _message = value;
  }

  set result(int value) {
    _result = value;
  }

  int get result => _result;
  String get message => _message;
}
