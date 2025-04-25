
class CategoriesModel {
  final String slug;
  final String name;
  final String url;

  CategoriesModel({
    required this.slug,
    required this.name,
    required this.url,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
    slug: json["slug"] ?? "",
    name: json["name"] ?? "",
    url: json["url"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "slug": slug,
    "name": name,
    "url": url,
  };
}
