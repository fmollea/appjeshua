class ResponseDto {
  String status;
  int code;
  String message;

  ResponseDto(this.status, this.code, this.message);

  ResponseDto.fromJson(Map<String, dynamic> snapshot) {
    status = snapshot['status'];
    code = snapshot['code'];
    message = snapshot['message'];
  }
}