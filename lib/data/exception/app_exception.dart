class AppException implements Exception {
  final _message;
  final _prefix;

  AppException(this._message, this._prefix);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, "");
  //: super(message, "Error During Communication \n");
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, "Invalid Request \n");
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String? message])
      : super(message, "Unauthorized Request");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message])
      : super(message, "Invalid Input Exception \n");
}

class InternalSeverException extends AppException {
  InternalSeverException([String? message])
      : super(message, "Internal Sever Error");
}

class FormatException extends AppException{
   FormatException([String? message])
      : super(message, "format exception");
}

class ErrorException {}
