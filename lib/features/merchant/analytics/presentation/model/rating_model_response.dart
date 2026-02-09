import 'dart:convert';

class RatingSummaryModel {
    bool? success;
    String? message;
    Data? data;
    int? code;

    RatingSummaryModel({
        this.success,
        this.message,
        this.data,
        this.code,
    });

    RatingSummaryModel copyWith({
        bool? success,
        String? message,
        Data? data,
        int? code,
    }) => 
        RatingSummaryModel(
            success: success ?? this.success,
            message: message ?? this.message,
            data: data ?? this.data,
            code: code ?? this.code,
        );

    factory RatingSummaryModel.fromRawJson(String str) => RatingSummaryModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RatingSummaryModel.fromJson(Map<String, dynamic> json) => RatingSummaryModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
        "code": code,
    };
}

class Data {
    TotalMetrics? totalMetrics;
    RatingSummary? ratingSummary;
    List<TopPerformingReview>? topPerformingReviews;

    Data({
        this.totalMetrics,
        this.ratingSummary,
        this.topPerformingReviews,
    });

    Data copyWith({
        TotalMetrics? totalMetrics,
        RatingSummary? ratingSummary,
        List<TopPerformingReview>? topPerformingReviews,
    }) => 
        Data(
            totalMetrics: totalMetrics ?? this.totalMetrics,
            ratingSummary: ratingSummary ?? this.ratingSummary,
            topPerformingReviews: topPerformingReviews ?? this.topPerformingReviews,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalMetrics: json["total_metrics"] == null ? null : TotalMetrics.fromJson(json["total_metrics"]),
        ratingSummary: json["rating_summary"] == null ? null : RatingSummary.fromJson(json["rating_summary"]),
        topPerformingReviews: json["top_performing_reviews"] == null ? [] : List<TopPerformingReview>.from(json["top_performing_reviews"]!.map((x) => TopPerformingReview.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total_metrics": totalMetrics?.toJson(),
        "rating_summary": ratingSummary?.toJson(),
        "top_performing_reviews": topPerformingReviews == null ? [] : List<dynamic>.from(topPerformingReviews!.map((x) => x.toJson())),
    };
}

class RatingSummary {
    double? averageRating;
    int? totalReviews;
    List<ReviewDatum>? reviewData;

    RatingSummary({
        this.averageRating,
        this.totalReviews,
        this.reviewData,
    });

    RatingSummary copyWith({
        double? averageRating,
        int? totalReviews,
        List<ReviewDatum>? reviewData,
    }) => 
        RatingSummary(
            averageRating: averageRating ?? this.averageRating,
            totalReviews: totalReviews ?? this.totalReviews,
            reviewData: reviewData ?? this.reviewData,
        );

    factory RatingSummary.fromRawJson(String str) => RatingSummary.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RatingSummary.fromJson(Map<String, dynamic> json) => RatingSummary(
        averageRating: json["average_rating"]?.toDouble(),
        totalReviews: json["total_reviews"],
        reviewData: json["review_data"] == null ? [] : List<ReviewDatum>.from(json["review_data"]!.map((x) => ReviewDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "average_rating": averageRating,
        "total_reviews": totalReviews,
        "review_data": reviewData == null ? [] : List<dynamic>.from(reviewData!.map((x) => x.toJson())),
    };
}

class ReviewDatum {
    int? star;
    int? count;

    ReviewDatum({
        this.star,
        this.count,
    });

    ReviewDatum copyWith({
        int? star,
        int? count,
    }) => 
        ReviewDatum(
            star: star ?? this.star,
            count: count ?? this.count,
        );

    factory ReviewDatum.fromRawJson(String str) => ReviewDatum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ReviewDatum.fromJson(Map<String, dynamic> json) => ReviewDatum(
        star: json["star"],
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "star": star,
        "count": count,
    };
}

class TopPerformingReview {
    String? userName;
    String? userAvatar;
    int? rating;
    String? categoryName;
    String? createdAt;
    String? comment;

    TopPerformingReview({
        this.userName,
        this.userAvatar,
        this.rating,
        this.categoryName,
        this.createdAt,
        this.comment,
    });

    TopPerformingReview copyWith({
        String? userName,
        String? userAvatar,
        int? rating,
        String? categoryName,
        String? createdAt,
        String? comment,
    }) => 
        TopPerformingReview(
            userName: userName ?? this.userName,
            userAvatar: userAvatar ?? this.userAvatar,
            rating: rating ?? this.rating,
            categoryName: categoryName ?? this.categoryName,
            createdAt: createdAt ?? this.createdAt,
            comment: comment ?? this.comment,
        );

    factory TopPerformingReview.fromRawJson(String str) => TopPerformingReview.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TopPerformingReview.fromJson(Map<String, dynamic> json) => TopPerformingReview(
        userName: json["user_name"],
        userAvatar: json["user_avatar"],
        rating: json["rating"],
        categoryName: json["category_name"],
        createdAt: json["created_at"],
        comment: json["comment"],
    );

    Map<String, dynamic> toJson() => {
        "user_name": userName,
        "user_avatar": userAvatar,
        "rating": rating,
        "category_name": categoryName,
        "created_at": createdAt,
        "comment": comment,
    };
}

class TotalMetrics {
    int? totalClicks;
    int? totalClicksLastWeek;
    int? totalViews;
    int? totalViewsLastWeek;
    double? averageRating;
    int? averageRatingLastWeek;

    TotalMetrics({
        this.totalClicks,
        this.totalClicksLastWeek,
        this.totalViews,
        this.totalViewsLastWeek,
        this.averageRating,
        this.averageRatingLastWeek,
    });

    TotalMetrics copyWith({
        int? totalClicks,
        int? totalClicksLastWeek,
        int? totalViews,
        int? totalViewsLastWeek,
        double? averageRating,
        int? averageRatingLastWeek,
    }) => 
        TotalMetrics(
            totalClicks: totalClicks ?? this.totalClicks,
            totalClicksLastWeek: totalClicksLastWeek ?? this.totalClicksLastWeek,
            totalViews: totalViews ?? this.totalViews,
            totalViewsLastWeek: totalViewsLastWeek ?? this.totalViewsLastWeek,
            averageRating: averageRating ?? this.averageRating,
            averageRatingLastWeek: averageRatingLastWeek ?? this.averageRatingLastWeek,
        );

    factory TotalMetrics.fromRawJson(String str) => TotalMetrics.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TotalMetrics.fromJson(Map<String, dynamic> json) => TotalMetrics(
        totalClicks: json["total_clicks"],
        totalClicksLastWeek: json["total_clicks_last_week"],
        totalViews: json["total_views"],
        totalViewsLastWeek: json["total_views_last_week"],
        averageRating: json["average_rating"]?.toDouble(),
        averageRatingLastWeek: json["average_rating_last_week"],
    );

    Map<String, dynamic> toJson() => {
        "total_clicks": totalClicks,
        "total_clicks_last_week": totalClicksLastWeek,
        "total_views": totalViews,
        "total_views_last_week": totalViewsLastWeek,
        "average_rating": averageRating,
        "average_rating_last_week": averageRatingLastWeek,
    };
}
