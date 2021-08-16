class AuthorResponse {
  int id;
  String nama;
  String tanggalLahir;
  GenreSpecialization genreSpecialization;

  AuthorResponse(
      {this.id, this.nama, this.tanggalLahir, this.genreSpecialization});

  AuthorResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    tanggalLahir = json['tanggalLahir'];
    genreSpecialization = json['genreSpecialization'] != null
        ? new GenreSpecialization.fromJson(json['genreSpecialization'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['tanggalLahir'] = this.tanggalLahir;
    if (this.genreSpecialization != null) {
      data['genreSpecialization'] = this.genreSpecialization.toJson();
    }
    return data;
  }
}

class GenreSpecialization {
  int id;
  String name;

  GenreSpecialization({this.id, this.name});

  GenreSpecialization.fromJson(Map<String, dynamic> json) {
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