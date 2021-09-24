class _ContentPreviewBase {
  final int id;
  final String title;
  final String overview;

  /// URL of the photo
  final String thumbnail;
  final String address;
  final int catCode;
  final int heartNo;
  final bool hearted;

  _ContentPreviewBase.fromJson({required Map<String, dynamic> json})
      : id = json["id"] as int,
        title = json["title"] as String,
        overview = json["overview"] as String,
        thumbnail = json["thumbnail"] as String,
        address = json["address"] as String,
        catCode = json["cat_code"] as int,
        heartNo = json["heart_no"] as int,
        hearted = json["hearted"] as bool;
}

class ContentPreview extends _ContentPreviewBase {
  final double rating;
  final int reviewNo;

  ContentPreview.fromJson({required Map<String, dynamic> json})
      : rating = json["rating"] as double,
        reviewNo = json["review_no"] as int,
        super.fromJson(json: json);
}

class WishlistContentPreview extends _ContentPreviewBase {
  final double ratingNo;

  WishlistContentPreview.fromJson({required Map<String, dynamic> json})
      : ratingNo = json["rating_no"] as double,
        super.fromJson(json: json);
}
