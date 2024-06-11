import 'package:flutter/material.dart';

TextEditingController jamDaftarController = TextEditingController();

class JamDaftar extends StatefulWidget {
  final TimeOfDay? initialValue;
  final void Function(TimeOfDay)? onChanged;

  const JamDaftar({
    Key? key,
    this.initialValue,
    this.onChanged,
  }) : super(key: key);

  @override
  State<JamDaftar> createState() => _JamDaftarState();
}

class _JamDaftarState extends State<JamDaftar> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: jamDaftarController,
      decoration: InputDecoration(
        labelText: "Jam Daftar",
        suffix: IconButton(
          onPressed: () {
            pilihJam();
          },
          icon: Icon(Icons.timer),
        ),
      ),
    );
  }

  Future<void> pilihJam() async {
    TimeOfDay? jamDidapat =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (jamDidapat != null) {
      jamDaftarController.text = jamDidapat.toString().replaceAll("TimeOfDay(", "").replaceAll(")", "");
      // Panggil onChanged dengan parameter yang sesuai jika tidak null
      widget.onChanged?.call(jamDidapat);
    }
  }
}
