import 'package:flutter/material.dart';

List<String> bahasaDipilihList = [];

class KemampuanBerbahasa extends StatefulWidget {
  final List<String> initialSelectedLanguages;

  const KemampuanBerbahasa({Key? key, required this.initialSelectedLanguages}) : super(key: key);

  @override
  State<KemampuanBerbahasa> createState() => _KemampuanBerbahasaState();
}

class _KemampuanBerbahasaState extends State<KemampuanBerbahasa> {
  List<String> bahasaList = [
    "Indonesia",
    "Inggris",
    "Arab",
    "Sunda",
    "Jawa",
    "Madura",
    "Jepang",
    "Korea",
    "Mandarin"
  ];

  @override
  void initState() {
    super.initState();
    bahasaDipilihList.addAll(widget.initialSelectedLanguages);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Kemampuan berbahasa"),
        Container(
          height: 100,
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 4 / 1,
            ),
            children: bahasaList.map((e) => OpsiBahasa(strBahasa: e)).toList(),
          ),
        ),
      ],
    );
  }
}

class OpsiBahasa extends StatefulWidget {
  final String strBahasa;

  const OpsiBahasa({Key? key, required this.strBahasa}) : super(key: key);

  @override
  State<OpsiBahasa> createState() => _OpsiBahasaState();
}

class _OpsiBahasaState extends State<OpsiBahasa> {
  late bool opsiDipilih;

  @override
  void initState() {
    super.initState();
    // Set initial value based on the initialSelectedLanguages
    opsiDipilih = bahasaDipilihList.contains(widget.strBahasa);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Checkbox(
            value: opsiDipilih,
            onChanged: (value) {
              setState(() {
                opsiDipilih = value!;
                if (value) {
                  bahasaDipilihList.add(widget.strBahasa);
                } else {
                  bahasaDipilihList.remove(widget.strBahasa);
                }
              });
            },
          ),
          Text(widget.strBahasa)
        ],
      ),
    );
  }
}
