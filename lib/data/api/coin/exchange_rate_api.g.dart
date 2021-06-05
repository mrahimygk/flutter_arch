// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_rate_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ExchangeRateApi implements ExchangeRateApi {
  _ExchangeRateApi(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<HistoryPeriod>> getHistoryPeriods() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<HistoryPeriod>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'exchangerate/history/periods/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => HistoryPeriod.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<ExchangeRateResponse> getExchangeRatesForCoin(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ExchangeRateResponse>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'exchangerate/$id/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ExchangeRateResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<RateHistory>> getRateHistoryForTwoCoins(
      baseCoinId, quoteCoinId, startTime, endTime, periodId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'time_start': startTime,
      r'time_end': endTime,
      r'period_id': periodId
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<RateHistory>>(Options(
                method: 'GET', headers: <String, dynamic>{}, extra: _extra)
            .compose(
                _dio.options, 'exchangerate/$baseCoinId/$quoteCoinId/history/',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => RateHistory.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
