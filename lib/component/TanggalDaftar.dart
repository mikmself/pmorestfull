import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import paket intl untuk DateFormat

TextEditingController tanggalDaftarController = TextEditingController();

class TanggalDaftar extends StatefulWidget {
  final DateTime? initialValue;
  final void Function(DateTime)? onChanged;

  const TanggalDaftar({
    Key? key,
    this.initialValue,
    this.onChanged,
  }) : super(key: key);

  @override
  State<TanggalDaftar> createState() => _TanggalDaftarState();
}

class _TanggalDaftarState extends State<TanggalDaftar> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: tanggalDaftarController,
      decoration: InputDecoration(
        labelText: "Tanggal Daftar",
        suffix: IconButton(
          onPressed: () {
            pilihTanggal();
          },
          icon: Icon(Icons.date_range),
        ),
      ),
    );
  }

  Future<void> pilihTanggal() async {
    DateTime? tglDidapat;
    tglDidapat = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2025),
    );
    if (tglDidapat != null) {
      // Format tanggal
      String formattedDate = DateFormat('yyyy-MM-dd').format(tglDidapat);
      // Update teks pada controller
      tanggalDaftarController.text = formattedDate;
    }
  }
}
