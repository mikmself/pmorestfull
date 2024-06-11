import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restfull/EditPage.dart';
import 'package:restfull/PendaftaranAdd.dart';
import 'package:restfull/PendaftaranModel.dart';
import 'package:restfull/konstanta.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DataPendaftaran(),
    );
  }
}

class DataPendaftaran extends StatefulWidget {
  const DataPendaftaran({super.key});

  @override
  State<DataPendaftaran> createState() => _DataPendaftaranState();
}

class _DataPendaftaranState extends State<DataPendaftaran> {
  List<PendaftaranModel> pendaftaranList = [];

  Future ambilDataPendaftaran() async {
    var url = Uri.parse(baseUrl + "pendaftaran");
    var respons = await http.get(url);
    List responseDecode = jsonDecode(respons.body);
    pendaftaranList.clear();
    for (var element in responseDecode) {
      pendaftaranList.add(PendaftaranModel.fromJson(element));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Data Pendaftaran"),
        ),
        body: FutureBuilder(
        future: ambilDataPendaftaran(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return const Center(
    child: CircularProgressIndicator(),
    );
    } else {
    if (pendaftaranList.length == 0) {
    return const Center(
    child: Text("Data Kosong"),
    );
    } else {
    return ListView.builder(
    itemCount: pendaftaranList.length,
    itemBuilder: (context, index) => Card(
    color: Colors.green.shade50,
    child: ListTile(
    trailing: Container(
    width: 100,
    child: Row(
    children: [
    IconButton(
    onPressed: () async {
    showDialog(
    context: context,
    builder: (context) => AlertDialog(
    title: Text("Hapus Data"),
    content: Text(
    "Apakah anda yakin akanmenghapus data?"),
    actions: [
    ElevatedButton(
    onPressed: () async {
    var url = Uri.parse(baseUrl +
    "pendaftaran/${pendaftaranList[index].id}");
    var repsonse = await http.delete(url);
    setState(() {});
    Navigator.pop(context);
    },
    child: Text("Ya"),
    ),
    ElevatedButton(
    onPressed: () {
    Navigator.pop(context);
    },
    child: Text("Tidak"),
    ),
    ],
    ),
    );
    },
    icon: Icon(Icons.delete),
    ),
    IconButton(
    onPressed: () async {
    showDialog(
    context: context,
    builder: (context) => AlertDialog(
    title: Text("Edit Data"),
    content: Text(
    "Apakah anda yakin akan mengedit data?"),
    actions: [
    ElevatedButton(
    // onPressed: () async {
    //   var url = Uri.parse(baseUrl +
    //       "pendaftaran/${pendaftaranList[index].id}");
    //   var respons = await http.put(
    //     url,
    //     body: PendaftaranModel(
    //             nama: "Contoh Nama ",
    //             email: "email@gmail.com",
    //             noTelpon: "23242322",
    //             jenisKelamin: "Pria",
    //             bahasa: "Indonesia",
    //             agama: "Islam",
    //             tanggalDaftar: "2024-01-01",
    //             jamDaftar: "20:00:00")
    //         .toJson(),
    //   );
    onPressed: () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => EditPendaftaranPage(pendaftaran: pendaftaranList[index]),));
    },
    child: Text("Ya"),
    ),
    ElevatedButton(
    onPressed: () {
    Navigator.pop(context);
    },
    child: Text("Tidak"),
    ),
    ],
    ),
    );
    },
    icon: Icon(Icons.edit),
    ),
    ],
    ),
    ),
    title: Text(pendaftaranList[index].id!),
    subtitle:Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text('nama : ${pendaftaranList[index].nama!}'),
    Text('email : ${pendaftaranList[index].email!}'),
    Text('noTelpon : ${pendaftaranList[index].noTelpon!}'),
    Text('jenisKelamin : ${pendaftaranList[index].jenisKelamin!}'),
    Text('bahasa : ${pendaftaranList[index].bahasa!}'),
    Text('agama : ${pendaftaranList[index].agama!}'),
    Text('tanggalDaftar : ${pendaftaranList[index].tanggalDaftar!}'),
    Text('jamDaftar : ${pendaftaranList[index].jamDaftar!}'),
    ],
    )
    ),
    ),
    );
    }
    }
  }

  ,

  )

  ,

  floatingActionButton

      :

  FloatingActionButton

  (

  onPressed: () {
  Navigator.push(
  context,
  MaterialPageRoute(
  builder: (context) => PendaftaranAdd(),
  ),
  );
  },
  child: Icon(Icons.add),
  )

  ,

  );
}}
