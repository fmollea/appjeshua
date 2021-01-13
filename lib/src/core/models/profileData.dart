class ProfileData {

  int id;
  String fullname;
  String email;
  String phone;
  String movil;
  String city;
  String colony;
  String state;
  String postal;
  String country;
  String web;
  String image;

  ProfileData();

  ProfileData.fromJson(Map<String, dynamic> snapshot) {
    id = snapshot['id'];
    fullname = snapshot['fullname'];
    email = snapshot['email'];
    phone = snapshot['phone'];
    movil = snapshot['movil'];
    city = snapshot['city'];
    colony = snapshot['colony'];
    state = snapshot['state'];
    postal = snapshot['code'];
    web = snapshot['web'];
    image = snapshot['image'];
    country = snapshot['country'];
  }
}