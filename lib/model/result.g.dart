part of 'result.dart';

// 命令:
Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      json['code'] as int,
      json['method'] as String,
      json['requestPrams'] as String,
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'code': instance.code,
      'method': instance.method,
      'requestPrams': instance.requestPrams,
    };
