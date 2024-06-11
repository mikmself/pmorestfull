import 'package:flutter/material.dart';

class Pendaftaran{
  late BuildContext context;
  String nama = "";
  String email = "";
  String noTelp = "";
  String jenisKelamin = "";
  String bahasa = "";
  String agama = "";
  String tanggalDaftar = "";
  String jamDaftar = "";

  Pendaftaran(
    this.context,
    this.nama,
    this.email,
    this.noTelp,
    this.jenisKelamin,
    this.bahasa,
    this.agama,
    this.tanggalDaftar,
    this.jamDaftar
  );

  bool sudahValid(){
    if(nama.isEmpty){
      tampilkanPesan("Nama wajib diisi");
      return false;
    }
    if(email.isEmpty){
      tampilkanPesan("Email wajib diisi");
      return false;
    }
    if(noTelp.isEmpty){
      tampilkanPesan("Nomor telephone wajib diisi");
      return false;
    }
    if(jenisKelamin == null){
      tampilkanPesan("Silahkan pilih salah satu jenis kelamin");
      return false;
    }
    if(bahasa == "[]"){
      tampilkanPesan("Wajib memilih minimal satu bahasa");
      return false;
    }
    if(agama == "null"){
      tampilkanPesan("Wajib memilih satu agama");
      return false;
    }
    if (tanggalDaftar.isEmpty){
      tampilkanPesan("Tanggal daftar wajib diisi");
      return false;
    }
    if(jamDaftar.isEmpty){
      tampilkanPesan("Jam daftar wajib diisi");
      return false;
    }
    return true;
  }
  void tampilkanPesan(String pesan){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(pesan)));
  }
}
List<Pendaftaran> pendaftarList = [];

