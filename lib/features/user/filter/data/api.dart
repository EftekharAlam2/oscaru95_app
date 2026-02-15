import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:oscaru95/features/user/home/model/discover_response.dart';
import 'package:oscaru95/networks/dio/dio.dart';
import 'package:oscaru95/networks/endpoints.dart';
import 'package:oscaru95/networks/exception_handler/data_source.dart';

final class DiscoverFilterAPi {
  static final DiscoverFilterAPi _singleton = DiscoverFilterAPi._internal();
  DiscoverFilterAPi._internal();

  static DiscoverFilterAPi get instance => _singleton;

  Future<DiscoverResponse> filter({
    String? type,
    String? cusingId,
    String? cuisinId,
    String? days,
    String? min,
    String? max,
    String? searchQuery
  }) async {
    try {
      // Load from local JSON data
      final String jsonString = await rootBundle.loadString('assets/data/nearest_shops.json');
      final dynamic jsonData = json.decode(jsonString);

      List<dynamic> allShops = jsonData['data']['data'] as List? ?? [];

      double? minKm;
      double? maxKm;
      if (min != null && min.isNotEmpty) {
        minKm = double.tryParse(min);
      }
      if (max != null && max.isNotEmpty) {
        maxKm = double.tryParse(max);
      }

      // Helper to parse distance like "0.5 km" or "12.79 km" -> numeric value
      double parseDistance(String? d) {
        if (d == null) return double.infinity;
        final sanitized = d.toString().toLowerCase().replaceAll('km', '').trim();
        return double.tryParse(sanitized) ?? double.infinity;
      }

      // Apply filters
      var filteredShops = allShops.where((shop) {
        // Type filter
        if (type != null && type.isNotEmpty) {
          final shopType = (shop['type'] ?? '').toString().toLowerCase();
          if (!shopType.contains(type.toLowerCase())) {
            return false;
          }
        }

        // Search query filter (searches in venue name and address)
        if (searchQuery != null && searchQuery.isNotEmpty) {
          final venueName = (shop['venue_name'] ?? '').toString().toLowerCase();
          final address = (shop['address'] ?? '').toString().toLowerCase();
          if (!venueName.contains(searchQuery.toLowerCase()) &&
              !address.contains(searchQuery.toLowerCase())) {
            return false;
          }
        }

        // Distance filter
        if (minKm != null || maxKm != null) {
          final shopDistance = parseDistance(shop['distance']?.toString());
          if (minKm != null && shopDistance < minKm) return false;
          if (maxKm != null && shopDistance > maxKm) return false;
        }

        // Day filter (not implemented: requires open hours parsing)
        return true;
      }).toList();

      log('Filtered shops count: ${filteredShops.length}');
      log('Applied filters - Type: $type, Search: $searchQuery, min: $min, max: $max');

      final responseMap = {
        'success': true,
        'message': 'Filtered results retrieved successfully',
        'data': filteredShops,
        'code': 200
      };

      return DiscoverResponse.fromJson(responseMap);
    } catch (e) {
      log('Error in filter: $e');
      rethrow;
    }
  }
}
