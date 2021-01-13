import 'package:appjeshua/src/commons/Utils.dart';
import 'package:appjeshua/src/core/models/profileData.dart';
import 'package:appjeshua/src/core/services/apiLogin.dart';
import 'package:appjeshua/src/presentation/widget/circle_image_widget.dart';
import 'package:flutter/material.dart';

class DetailsProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Datos personales",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
        ),
        body: _drawScreen());
  }

  Widget _drawScreen() {
    final api = ApiLogin();
    return FutureBuilder(
      future: api.getProfileData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _drawInfo(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }
    );
  }

  Widget _drawInfo(ProfileData profileData) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
            children: [
              Container(height: 24),
              Center(child: CircleImageWidget(path: 
                getImagePath(profileData.image, profileData.id), width: 90, height: 90)),
              Container(height: 24),  
              drawRow('Nombre y apellido: ${profileData.fullname}'), 
              drawRow('Correo electrónico: ${profileData.email}'), 
              drawRow('Teléfono: ${profileData.phone}'), 
              drawRow('Ciudad: ${profileData.city}'), 
              drawRow('Colonia: ${profileData.colony}'), 
              drawRow('Estado: ${profileData.state}'), 
              drawRow('Código postal: ${profileData.postal}'), 
              drawRow('País: ${profileData.country}'), 
            ],
          ),
        ),
    );
  }

  String getImagePath(String path, int id) {
    if (path == null) return null;
    else return Utils.getPerfilImage(path, id);
  }

  drawDivider() {
    return Container(
        padding: EdgeInsets.only(left: 28, right: 28),
        child: Divider(color: Colors.grey, height: 2.0));
  }

  drawRow(String text) {
    return text.contains('null') ? Container() : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 14),
          child: Text(text, style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        drawDivider()
      ],
    ); 
  }
}