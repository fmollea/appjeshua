class User {
  User._private();

  static final User _instance = User._private();

  factory User() {
    return _instance;
  }

  String token;
  String name;
  String email;
  int deliveryId;
  int paymentId;
  int billingId;

  getInfoUser(Map<String, dynamic> snapshot) {
    // TODO eliminar comment
    /*
    final map = snapshot['data'];
    this.name = map['username'];
    this.email = map['email']; */

    this.name = 'TEST';
    this.email = 'test@gmal.com';
  }
}
