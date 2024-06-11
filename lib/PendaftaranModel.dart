class PendaftaranModel {
  String? id;
  String? nama;
  String? email;
  String? noTelpon;
  String? jenisKelamin;
  String? bahasa;
  String? agama;
  String? tanggalDaftar;
  String? jamDaftar;

  PendaftaranModel(
      {this.id,
        this.nama,
        this.email,
        this.noTelpon,
        this.jenisKelamin,
        this.bahasa,
        this.agama,
        this.tanggalDaftar,
        this.jamDaftar});

  PendaftaranModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    email = json['email'];
    noTelpon = json['no_telpon'];
    jenisKelamin = json['jenis_kelamin'];
    bahasa = json['bahasa'];
    agama = json['agama'];
    tanggalDaftar = json['tanggal_daftar'];
    jamDaftar = json['jam_daftar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id ?? "";
    data['nama']  = nama ?? "";
    data['email'] = email ?? "";
    data['no_telpon'] = noTelpon ?? "";
    data['jenis_kelamin'] = jenisKelamin ?? "";
    data['bahasa'] = bahasa ?? "";
    data['agama'] = agama ?? "";
    data['tanggal_daftar'] = tanggalDaftar ?? "";
    data['jam_daftar'] = jamDaftar ?? "";
    return data;
  }
}
