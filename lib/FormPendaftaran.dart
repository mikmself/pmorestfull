import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restfull/PendaftaranModel.dart';
import 'package:restfull/component/Agama.dart';
import 'package:restfull/component/JamDaftar.dart';
import 'package:restfull/component/KemampuanBerbahasa.dart';
import 'package:restfull/component/TanggalDaftar.dart';
import 'package:restfull/konstanta.dart';
import 'package:http/http.dart' as http;
import 'package:restfull/main.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.teal, foregroundColor: Colors.white),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.teal),
            foregroundColor: MaterialStatePropertyAll(Colors.white),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: FormPendaftaran(),
    );
  }
}
class FormPendaftaran extends StatefulWidget {
  const FormPendaftaran({super.key});

  @override
  State<FormPendaftaran> createState() => _FormPendaftaranState();
}

class _FormPendaftaranState extends State<FormPendaftaran> {
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController noTelpController = TextEditingController();

  String? jenisKelamin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Latihan Formulir"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextField(
              controller: namaController,
              decoration: InputDecoration(
                label: Text("Nama Lengkap"),
              ),
            ),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                label: Text("Email"),
              ),
            ),
            TextField(
              controller: noTelpController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                label: Text("No Telp"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: RadioListTile(
                    title: Text("Pria"),
                    value: "Pria",
                    groupValue: jenisKelamin,
                    onChanged: (value) {
                      setState(() {
                        jenisKelamin = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: Text("Wanita"),
                    value: "Wanita",
                    groupValue: jenisKelamin,
                    onChanged: (value) {
                      setState(() {
                        jenisKelamin = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            KemampuanBerbahasa(initialSelectedLanguages: [],),
            Column(
              children: [
                Agama(), // Menampilkan dropdown agama
                SizedBox(height: 10), // Spasi antara dropdown dan teks
                Text(agamaDipilih ?? ''), // Menampilkan nilai agama yang dipilih
              ],
            ),
            TanggalDaftar(),
            JamDaftar(),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      var url = Uri.parse(baseUrl + "pendaftaran");
                      var respons = await http.post(url,
                        body: PendaftaranModel(
                            nama: namaController.text,
                            email: emailController.text,
                            noTelpon: noTelpController.text,
                            jenisKelamin: jenisKelamin.toString(),
                            bahasa: bahasaDipilihList.toString(),
                            agama: agamaDipilih.toString(),
                            tanggalDaftar: tanggalDaftarController.text,
                            jamDaftar: jamDaftarController.text)
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
                    child: Text("Simpan"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DataPendaftaran(),
                          ));
                    },
                    child: Text("Lihat Data"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
