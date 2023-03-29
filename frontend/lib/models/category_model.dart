class Category {
  final int id;
  final String title;

  const Category({
    required this.id, 
    required this.title,
    });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
      };
}
