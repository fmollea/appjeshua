import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/profileData.dart';
import 'package:appjeshua/src/core/services/apiLogin.dart';
import 'package:appjeshua/src/presentation/widget/button_widget.dart';
import 'package:appjeshua/src/presentation/widget/text_input_widget.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  @override
  
  _EditProfilePageState createState() => _EditProfilePageState();
}


class _EditProfilePageState extends State<EditProfilePage> {

  var profileData = ProfileData();

  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController colony = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController postal = TextEditingController();
  TextEditingController movil = TextEditingController();
  TextEditingController web = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar datos",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold)),
      ),
      body: _drawScreen(),
      bottomNavigationBar: drawBottom());
  }

  Widget _drawScreen() {
    final api = ApiLogin();
    return FutureBuilder(
      future: api.getProfileData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          profileData = snapshot.data;
          loadInfo();
          return _drawInfo();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }
    );
  }

  _drawInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            drawRow(fullname, 'Nombre y apellido', TextInputType.name),
            drawRow(email, 'Correo electrónico', TextInputType.emailAddress),
            drawRow(phone, 'Teléfono', TextInputType.phone),
            drawRow(movil, 'Móvil', TextInputType.phone),
            drawRow(city, 'Ciudad', TextInputType.name),
            drawRow(colony, 'Cononia', TextInputType.name),
            drawRow(state, 'Estado', TextInputType.name),
            drawRow(postal, 'Código postal', TextInputType.number),
            drawRow(web, 'Web', TextInputType.text)
          ],
        ),
      ),
    );
  }

  loadInfo() {
    fullname.text = profileData.fullname;
    email.text = profileData.email;
    phone.text = profileData.phone;
    movil.text = profileData.movil;
    city.text = profileData.city;
    colony.text = profileData.colony;
    state.text = profileData.state;
    postal.text = profileData.postal;
    web.text = profileData.web;
  }

  bool checkInfoFields() => fullname.text != null && fullname.text.isNotEmpty && 
    email.text != null && email.text.isNotEmpty &&
    phone.text != null && phone.text.isNotEmpty &&
    movil.text != null && movil.text.isNotEmpty &&
    city.text != null && city.text.isNotEmpty &&
    colony.text != null && colony.text.isNotEmpty &&
    state.text != null && state.text.isNotEmpty &&
    postal.text != null && postal.text.isNotEmpty &&
    web.text != null && web.text.isNotEmpty;

  drawRow(TextEditingController controller, String text, TextInputType type) {
    return TextInputWidget(
      text: text,
      controller: controller,
      isPass: false,
      type: type,
    );
  }

  drawBottom() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ButtonWidget(editProfile, Utils.primaryColor, "Editar"),
    );
  }

  editProfile() async {
    if (checkInfoFields()) {
      final api = ApiLogin();
      final response = await api.editProfileData(profileData.id, fullname.text, email.text, phone.text, city.text,
        colony.text, state.text, postal.text, "", movil.text, web.text, null);

      Utils.showToast(
          "Perfil editado correctamente.",
          Colors.white,
          Colors.green);
    } else {
      Utils.showToast(
          "Debe completar todos los campos para editar su perfil.",
          Colors.white,
          Colors.red);
    }
  }
}