// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_broker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StockBrokerImpl _$$StockBrokerImplFromJson(Map<String, dynamic> json) =>
    _$StockBrokerImpl(
      category: json['category'] as String,
      brokerName: json['brokerName'] as String,
      dematAccountNumber: json['dematAccountNumber'] as String,
      comments: json['comments'] as String,
      attachment: json['attachment'] as String,
      assetId: json['assetId'] as int,
    );

Map<String, dynamic> _$$StockBrokerImplToJson(_$StockBrokerImpl instance) =>
    <String, dynamic>{
      'category': instance.category,
      'brokerName': instance.brokerName,
      'dematAccountNumber': instance.dematAccountNumber,
      'comments': instance.comments,
      'attachment': instance.attachment,
      'assetId': instance.assetId,
    };

_$StockBrokerResponseImpl _$$StockBrokerResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$StockBrokerResponseImpl(
      success: json['success'] as bool,
      message: json['message'] as String,
      assets: (json['assets'] as List<dynamic>)
          .map((e) => StockBroker.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$StockBrokerResponseImplToJson(
        _$StockBrokerResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'assets': instance.assets,
    };
