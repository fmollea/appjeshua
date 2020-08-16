class NetworkUtils {
  static isReqSuccess(int code) {
    if (code < 200 || code >= 300) {
      return false;
    } else {
      return true;
    }
  }
}
