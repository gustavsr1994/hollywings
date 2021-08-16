class MemberResponse {
  int id;
  String nama;
  String alamat;
  String tanggalLahir;
  List<Favorit> pengarangFavorit;
  List<Favorit> genreFavorit;

  MemberResponse(
      {this.id,
      this.nama,
      this.alamat,
      this.tanggalLahir,
      this.pengarangFavorit,
      this.genreFavorit});

  MemberResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    alamat = json['alamat'];
    tanggalLahir = json['tanggalLahir'];
    if (json['pengarangFavorit'] != null) {
      pengarangFavorit = new List<Favorit>();
      json['pengarangFavorit'].forEach((v) {
        pengarangFavorit.add(new Favorit.fromJson(v));
      });
    }
    if (json['genreFavorit'] != null) {
      genreFavorit = new List<Favorit>();
      json['genreFavorit'].forEach((v) {
        genreFavorit.add(new Favorit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['alamat'] = this.alamat;
    data['tanggalLahir'] = this.tanggalLahir;
    if (this.pengarangFavorit != null) {
      data['pengarangFavorit'] =
          this.pengarangFavorit.map((v) => v.toJson()).toList();
    }
    if (this.genreFavorit != null) {
      data['genreFavorit'] = this.genreFavorit.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Favorit {
  int id;
  String name;

  Favorit({this.id, this.name});

  Favorit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
