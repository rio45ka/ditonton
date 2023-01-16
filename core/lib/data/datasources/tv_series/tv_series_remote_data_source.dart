import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../utils/exception.dart';
import '../../models/tv_series/tv_series_api_response.dart';
import '../../models/tv_series/tv_series_detail_api_response.dart';
import '../../models/tv_series/tv_series_list_api_response.dart';

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeriesApiResponse>> getPopularTvSeries();
  Future<List<TvSeriesApiResponse>> getTopRatedTvSeries();
  Future<List<TvSeriesApiResponse>> getOnTheAirTvSeries();
  Future<List<TvSeriesApiResponse>> getTvSeriesRecommendations(int id);
  Future<List<TvSeriesApiResponse>> searchTvSeries(String query);
  Future<TvSeriesDetailApiResponse> getTvSeriesDetail(int id);
}

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  TvSeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvSeriesApiResponse>> getPopularTvSeries() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesListApiResponse.fromJson(json.decode(response.body))
          .tvSeriesList;
    } else {
      throw ServerException();
    }
  }

   @override
  Future<List<TvSeriesApiResponse>> getTopRatedTvSeries() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesListApiResponse.fromJson(json.decode(response.body))
          .tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesApiResponse>> getOnTheAirTvSeries() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesListApiResponse.fromJson(json.decode(response.body))
          .tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesApiResponse>> getTvSeriesRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesListApiResponse.fromJson(json.decode(response.body))
          .tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesApiResponse>> searchTvSeries(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return TvSeriesListApiResponse.fromJson(json.decode(response.body))
          .tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvSeriesDetailApiResponse> getTvSeriesDetail(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesDetailApiResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
