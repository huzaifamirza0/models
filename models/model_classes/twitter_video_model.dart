import '../../domain/entities/twitter_video.dart';
import '../../domain/mappers.dart';
import 'video_data_model.dart';

class TwitterVideoModel {
  final int code;
  final String msg;
  final double processedTime;
  final VideoDataModel? videoData;

  TwitterVideoModel({
    required this.code,
    required this.msg,
    required this.processedTime,
    this.videoData,
  });

  factory TwitterVideoModel.fromJson(Map<String, dynamic> json) {
    return TwitterVideoModel(
      code: json['code'] ?? 0,
      msg: json['msg'] ?? 'Success',
      processedTime: (json['processed_time'] as num?)?.toDouble() ?? 0.0,
      videoData: json['data'] != null ? VideoDataModel.fromJson(json['data']) : null,
    );
  }
}
