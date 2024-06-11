import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:restfull/PendaftaranModel.dart';
import 'package:restfull/component/JamDaftar.dart';
import 'package:restfull/component/KemampuanBerbahasa.dart';
import 'package:restfull/component/TanggalDaftar.dart';
import 'package:restfull/konstanta.dart';
import 'package:restfull/main.dart';

class EditPendaftaranPage extends StatefulWidget {
  final PendaftaranModel pendaftaran;

  EditPendaftaranPage({required this.pendaftaran});

  @override
  _EditPendaftaranPageState createState() => _EditPendaftaranPageState();
}

class _EditPendaftaranPageState extends State<EditPendaftaranPage> {
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController noTelpController = TextEditingController();
  String? jenisKelamin;
  String? agama;
  DateTime? tanggalDaftar;
  TimeOfDay? jamDaftar;

  @override
  void initState() {
    super.initState();
    // Mengisi nilai awal form dengan data yang akan diedit
    namaController.text = widget.pendaftaran.nama ?? '';
    emailController.text = widget.pendaftaran.email ?? '';
    noTelpController.text = widget.pendaftaran.noTelpon ?? '';
    jenisKelamin = widget.pendaftaran.jenisKelamin ?? '';
    agama = widget.pendaftaran.agama ?? '';
    tanggalDaftar = DateTime.tryParse(widget.pendaftaran.tanggalDaftar ?? '');
    // Konversi jam daftar dari String ke TimeOfDay
    List<String> timeComponents = widget.pendaftaran.jamDaftar!.split(':');
    jamDaftar = TimeOfDay(
      hour: int.parse(timeComponents[0]),
      minute: int.parse(timeComponents[1]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data Pendaftaran'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextField(
              controller: namaController,
              decoration: InputDecoration(
                labelText: 'Nama Lengkap',
              ),
            ),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: noTelpController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'No Telp',
              ),
            ),
            KemampuanBerbahasa(),
            ListTile(
              title: Text('Jenis Kelamin'),
              subtitle: Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      title: Text('Pria'),
                      value: 'Pria',
                      groupValue: jenisKelamin,
                      onChanged: (value) {
                        setState(() {
                          jenisKelamin = value as String?;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: Text('Wanita'),
                      value: 'Wanita',
                      groupValue: jenisKelamin,
                      onChanged: (value) {
                        setState(() {
                          jenisKelamin = value as String?;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Agama'),
              trailing: DropdownButton<String>(
                value: agama,
                onChanged: (String? value) {
                  setState(() {
                    agama = value;
                  });
                },
                items: <String>['Islam', 'Kristen', 'Katolik', 'Hindu', 'Buddha', 'Konghucu']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            TanggalDaftar(
              initialValue: tanggalDaftar,
              onChanged: (value) {
                setState(() {
                  tanggalDaftar = value;
                });
              },
            ),
            JamDaftar(
              initialValue: jamDaftar,
              onChanged: (value) {
                setState(() {
                  jamDaftar = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                var url = Uri.parse(baseUrl + 'pendaftaran/${widget.pendaftaran.id}');
                var response = await http.put(
                  url,
                  body: PendaftaranModel(
                    id: widget.pendaftaran.id,
                    nama: namaController.text,
                    email: emailController.text,
                    noTelpon: noTelpController.text,
                    jenisKelamin: jenisKelamin,
                    bahasa : bahasaDipilihList.toString(),
                    agama: agama,
                    tanggalDaftar: tanggalDaftar != null ? DateFormat('yyyy-MM-dd').format(tanggalDaftar!) : null,
                    jamDaftar: jamDaftar != null ? '${jamDaftar!.hour}:${jamDaftar!.minute}' : null,
                    // Isi dengan data yang lain sesuai kebutuhan
                  ).toJson(),
                );
                Map<String, dynamic> responseDecode =
                jsonDecode(response.body) as Map<String, dynamic>;
                if (response.statusCode == 200) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DataPendaftaran(),
                    ),
                  );
                } else {
                  // Jika gagal, tampilkan pesan kesalahan
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        responseDecode['messages']
                            .toString()
                            .replaceAll(",", "\n\n"),
                      ),
                    ),
                  );
                }
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
