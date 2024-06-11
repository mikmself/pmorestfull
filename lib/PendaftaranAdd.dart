import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restfull/PendaftaranModel.dart';
import 'package:restfull/main.dart';
import 'konstanta.dart';

class PendaftaranAdd extends StatefulWidget {
  const PendaftaranAdd({super.key});

  @override
  State<PendaftaranAdd> createState() => _PendaftaranAddState();
}

class _PendaftaranAddState extends State<PendaftaranAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah data Pendaftaran"),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DataPendaftaran(),
            ),
          );
        },
        child: ListView(
          children: [
            ElevatedButton(
                onPressed: () async {
                  var url = Uri.parse(baseUrl + "pendaftaran");
                  var respons = await http.post(url,
                    body: PendaftaranModel(
                            nama: "Contoh Nama",
                            email: "email@gmail.com",
                            noTelpon: "23242322",
                            jenisKelamin: "Pria",
                            bahasa: "Indonesia",
                            agama: "Islam",
                            tanggalDaftar: "2024-01-01",
                            jamDaftar: "20:00:00")
                        .toJson(),
                  );
                  Map<String, dynamic> responseDecode =
                      jsonDecode(respons.body) as Map<String, dynamic>;
                  if (responseDecode.toString().contains("error")) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          responseDecode['messages']
                              .toString()
                              .replaceAll(",", "\n\n"),
                        ),
                      ),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DataPendaftaran(),
                      ),
                    );
                  }
                },
                child: Text("Simpan"))
          ],
        ),
      ),
    );
  }
}
