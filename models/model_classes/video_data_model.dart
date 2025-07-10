import '../../domain/entities/video_data.dart';

// data/models/video_data_model.dart
class VideoDataModel extends VideoData {
  const VideoDataModel({
    required super.id,
    required super.duration,
    required super.title,
    required super.originCover,
    required super.authorThumb,
    required super.playVideo,
    required super.author,
  });

  factory VideoDataModel.fromJson(Map<String, dynamic> json) {
    return VideoDataModel(
      id: json["id"] ?? '',
      duration: json["duration"] ?? 0,
      title: json["title"] ?? 'Untitled',
      originCover: json["origin_cover"] ?? '',
      authorThumb: json["author_thumb"] ?? '',
      playVideo: json["play"] ?? '',
      author: json["author"] ?? 'Unknown',
    );
  }
}
