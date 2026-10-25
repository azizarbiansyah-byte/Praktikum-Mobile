class Article {
  final String title;
  final String description;
  final String urlToImage;

  Article({
    required this.title,
    required this.description,
    required this.urlToImage,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: (json['title'] ?? 'Tanpa judul') as String,
      description: (json['description'] ?? 'Tidak ada deskripsi.') as String,
      urlToImage: (json['urlToImage'] ?? '') as String,
    );
  }
}