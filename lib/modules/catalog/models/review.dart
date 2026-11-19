// model 1 review, isinya sama kayak json dari /api/v1/catalog/products/<id>/reviews/

class Review {
  final int id;
  final String username;
  final int rating;
  final String comment;
  final DateTime createdAt;
  // true kalau review ini punya user yang lagi login
  final bool isMine;

  Review({
    required this.id,
    required this.username,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.isMine,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        username: json["username"],
        rating: json["rating"],
        comment: json["comment"],
        createdAt: DateTime.parse(json["created_at"]).toLocal(),
        isMine: json["is_mine"] ?? false,
      );
}
