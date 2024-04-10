import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'stock_broker.freezed.dart';
part 'stock_broker.g.dart';

/*
{
    "success": true,
    "message": "Assets fetched successfully",
    "assets": [
        {
            "category": "StockBroker",
            "brokerName": "",
            "dematAccountNumber": "",
            "comments": "",
            "attachment": "",
            "assetId": 68
        },
        {
            "category": "StockBroker",
            "brokerName": "1",
            "dematAccountNumber": "2",
            "comments": "3",
            "attachment": "4",
            "assetId": 69
        },
        {
            "category": "StockBroker",
            "brokerName": "raju",
            "dematAccountNumber": "12345",
            "comments": "jhdgf",
            "attachment": "jgca",
            "assetId": 106
        }
    ]
} 
*/

// create  freezed classes for StockBroker

@freezed
abstract class StockBroker with _$StockBroker {
  const factory StockBroker({
    required String category,
    required String brokerName,
    required String dematAccountNumber,
    required String comments,
    required String attachment,
    required int assetId,
  }) = _StockBroker;

  factory StockBroker.fromJson(Map<String, Object?> json) =>
      _$StockBrokerFromJson(json);
}

@freezed
abstract class StockBrokerResponse with _$StockBrokerResponse {
  const factory StockBrokerResponse({
    required bool success,
    required String message,
    required List<StockBroker> assets,
  }) = _StockBrokerResponse;

  factory StockBrokerResponse.fromJson(Map<String, Object?> json) =>
      _$StockBrokerResponseFromJson(json);
}
