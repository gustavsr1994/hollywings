class MemberRequest {
  String alamat;
  List<int> genreFavorit;
  String nama;
  List<int> pengarangFavorit;
  String tanggalLahir;

  MemberRequest(
      {this.alamat,
      this.genreFavorit,
      this.nama,
      this.pengarangFavorit,
      this.tanggalLahir});

  MemberRequest.fromJson(Map<String, dynamic> json) {
    alamat = json['alamat'];
    genreFavorit = json['genreFavorit'].cast<int>();
    nama = json['nama'];
    pengarangFavorit = json['pengarangFavorit'].cast<int>();
    tanggalLahir = json['tanggalLahir'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alamat'] = this.alamat;
    data['genreFavorit'] = this.genreFavorit;
    data['nama'] = this.nama;
    data['pengarangFavorit'] = this.pengarangFavorit;
    data['tanggalLahir'] = this.tanggalLahir;
    return data;
  }
}
