class ErrorResponse {
  String? detail;
  String? code;

  ErrorResponse({
    this.detail,
    this.code,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      detail: json['detail'],
      code: json['code'],
    );
  }
}

class SuccessResponse {
  String? access;

  SuccessResponse({
    this.access,
  });

  factory SuccessResponse.fromJson(Map<String, dynamic> json) {
    return SuccessResponse(
      access: json['access'],
    );
  }
}

class APIResponse {
  ErrorResponse? errorResponse;
  SuccessResponse? successResponse;

  APIResponse({
    this.errorResponse,
    this.successResponse,
  });

  factory APIResponse.fromJson(Map<String, dynamic> json) {
    return APIResponse(
      errorResponse:
          json.containsKey('detail') ? ErrorResponse.fromJson(json) : null,
      successResponse:
          json.containsKey('access') ? SuccessResponse.fromJson(json) : null,
    );
  }
}
