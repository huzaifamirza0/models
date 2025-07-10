import 'dart:convert';
import 'dart:io';



import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/internet_util.dart';
import '../../../core/utils/shared_preferences_helper.dart';
import '../entity/dealer_type.dart';
import '../entity/dealer_visit_history.dart';
import '../entity/dealers.dart';
import '../entity/district.dart';
import '../entity/login.dart';
import '../entity/schools.dart';
import '../entity/tehsil.dart';
import '../entity/vehicle_type.dart';
import '../entity/visit_history.dart';
import '../entity/visit_type.dart';
import 'base_client.dart';

class ApiClient extends BaseClient1 {
  final String baseUrl;

  ApiClient({
    required Logger log,
    required this.baseUrl,
  }) : super(log: log);


  final String schoolVisitAPI = "api/visit_school";

  Future<SchoolsReponse> getSchools() async {
    String deviceId = await SharedPreferencesHelper.getDeviceId();
    print(deviceId);
    final queryParameters = {
      'device_id': deviceId,
      'app_version': '${api_version}',
    };
    final token = await SharedPreferencesHelper.getToken();
    final response = await get(
      '${server_url}api/schools',
      headers: {
        "Content-Type": "application/json",
        "Authorization": "${token}",
      },
      queryParameters: queryParameters,
    );
    await Future.delayed(const Duration(seconds: 1));
    print(response.body);
    return SchoolsReponse.fromJson(
      jsonDecode(response.body)['schools'],
    );
  }

  Future<DealersReponse> getDealers() async {
    String deviceId = await SharedPreferencesHelper.getDeviceId();
    print(deviceId);
    final queryParameters = {
      'device_id': deviceId,
      'app_version': '${api_version}',
    };
    final token = await SharedPreferencesHelper.getToken();
    final response = await get(
      '${server_url}api/dealers',
      headers: {
        "Content-Type": "application/json",
        "Authorization": "${token}",
      },
      queryParameters: queryParameters,
    );
    await Future.delayed(const Duration(seconds: 1));
    print(response.body);
    return DealersReponse.fromJson(
      jsonDecode(response.body)['dealers'],
    );
  }

  Future<VisitTypeReponse> getVisitTypes() async {
    String deviceId = await SharedPreferencesHelper.getDeviceId();
    print(deviceId);
    final queryParameters = {
      'device_id': deviceId,
      'app_version': '${api_version}',
    };

    final token = await SharedPreferencesHelper.getToken();
    final response = await get(
      '${server_url}api/visit_types',
      headers: {
        "Content-Type": "application/json",
        "Authorization": "${token}",
      },
      queryParameters: queryParameters,
    );
    await Future.delayed(const Duration(seconds: 1));
    print(response.body);

    return VisitTypeReponse.fromJson(
      jsonDecode(response.body)['visit_types'],
    );
  }

  Future<DealerTypeReponse> getDealerTypes() async {
    String deviceId = await SharedPreferencesHelper.getDeviceId();
    print(deviceId);
    final queryParameters = {
      'device_id': deviceId,
      'app_version': '${api_version}',
    };

    final token = await SharedPreferencesHelper.getToken();
    final response = await get(
      '${server_url}api/visit_types',
      headers: {
        "Content-Type": "application/json",
        "Authorization": "${token}",
      },
      queryParameters: queryParameters,
    );
    await Future.delayed(const Duration(seconds: 1));
    print(response.body);

    return DealerTypeReponse.fromJson(
      jsonDecode(response.body)['visit_types'],
    );
  }

  Future<VehicleTypeReponse> getVehicleTypes() async {
    String deviceId = await SharedPreferencesHelper.getDeviceId();
    print(deviceId);
    final queryParameters = {
      'device_id': deviceId,
      'app_version': '${api_version}',
    };
    final token = await SharedPreferencesHelper.getToken();
    final response = await get(
      '${server_url}api/vehicletypes',
      headers: {
        "Content-Type": "application/json",
        "Authorization": "${token}",
      },
      queryParameters: queryParameters,
    );
    await Future.delayed(const Duration(seconds: 1));
    print(response.body);

    return VehicleTypeReponse.fromJson(
      jsonDecode(response.body)['vehicletypes'],
    );
  }

  Future<DistrictReponse> getDistricts() async {
    String deviceId = await SharedPreferencesHelper.getDeviceId();
    print(deviceId);
    final queryParameters = {
      'device_id': deviceId,
      'app_version': '${api_version}',
    };

    final token = await SharedPreferencesHelper.getToken();
    final response = await get(
      '${server_url}api/districts',
      headers: {
        "Content-Type": "application/json",
        "Authorization": "${token}",
      },
      queryParameters: queryParameters,
    );
    await Future.delayed(const Duration(seconds: 1));
    print(response.body);

    return DistrictReponse.fromJson(
      jsonDecode(response.body)['districts'],
    );
  }

  Future<TehsilReponse> getTehsils() async {
    String deviceId = await SharedPreferencesHelper.getDeviceId();
    print(deviceId);
    final queryParameters = {
      'device_id': deviceId,
      'app_version': '${api_version}',
    };

    final token = await SharedPreferencesHelper.getToken();
    final response = await get(
      "${server_url}api/tehsils",
      headers: {
        "Content-Type": "application/json",
        "Authorization": "${token}",
      },
      queryParameters: queryParameters,
    );
    await Future.delayed(const Duration(seconds: 1));
    print(response.body);

    return TehsilReponse.fromJson(
      jsonDecode(response.body)['tehsils'],
    );
  }


  Future<LoginReponse> login(String phone, String password) async {
    print(password);

    String deviceId = await SharedPreferencesHelper.getDeviceId();
    print(deviceId);
    final queryParameters = {
      'device_id': deviceId,
      'app_version': '${api_version}',
    };

    final uri = Uri.parse('${server_url}api/login')
        .replace(queryParameters: queryParameters);
    final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        <String, String>{
          'phone': phone,
          'password': password,
          'device_id': deviceId,
        },
      ),
    );

    await Future.delayed(const Duration(seconds: 1));
    print('CALL API');

    var d = LoginReponse.fromJson(jsonDecode(response.body));
    print(d.data.message);
    print(d.data.status_code.toString());
    return d;
  }

  Future<dynamic> createSchoolMultipart(
      String filePath, Map<String, dynamic> bodyFields) async {
    final token = await SharedPreferencesHelper.getToken();
    print('print before token');
    String deviceId = await SharedPreferencesHelper.getDeviceId();
    print(deviceId);
    final queryParameters = {
      'device_id': deviceId,
      'app_version': '${api_version}',
    };

    final response = await postMultipart(
      '${server_url}api/store-school',
      filePath,
      headers: {
        'Content-type': 'multipart/form-data',
        "Accept": "application/json",
        "Authorization": "${token}"
      },
      formParameters: bodyFields,
      queryParameters: queryParameters,
    );
    await Future.delayed(const Duration(seconds: 1));
    print('CALL API');
    print(response);
    return response;
  }

  Future<dynamic> createDealerMultipart(
      String filePath, Map<String, dynamic> bodyFields) async {
    final token = await SharedPreferencesHelper.getToken();
    print('print before token');
    String deviceId = await SharedPreferencesHelper.getDeviceId();
    print(deviceId);
    final queryParameters = {
      'device_id': deviceId,
      'app_version': '${api_version}',
    };

    final response = await postMultipart(
      '${server_url}api/store-dealer',
      filePath,
      headers: {
        'Content-type': 'multipart/form-data',
        "Accept": "application/json",
        "Authorization": "${token}"
      },
      formParameters: bodyFields,
      queryParameters: queryParameters,
    );
    await Future.delayed(const Duration(seconds: 1));
    print('Dealer API Call');
    print(response);
    return response;
  }

  Future<dynamic> existingSchoolVisitMultipart(
      String filePath, Map<String, dynamic> bodyFields) async {
    final token = await SharedPreferencesHelper.getToken();
    print('print before token');
    String deviceId = await SharedPreferencesHelper.getDeviceId();
    print(deviceId);
    final queryParameters = {
      'device_id': deviceId,
      'app_version': '${api_version}',
    };

    final response = await postMultipart(
      '${server_url}api/visit_school',
      filePath,
      headers: {
        'Content-type': 'multipart/form-data',
        "Accept": "application/json",
        "Authorization": "${token}"
      },
      formParameters: bodyFields,
      queryParameters: queryParameters,
    );
    await Future.delayed(const Duration(seconds: 1));
    print('CALL API');
    print(response);
    return response;
  }

  Future<dynamic> existingDealerVisitMultipart(
      String filePath, Map<String, dynamic> bodyFields) async {
    final token = await SharedPreferencesHelper.getToken();
    String deviceId = await SharedPreferencesHelper.getDeviceId();
    print(deviceId);
    final queryParameters = {
      'device_id': deviceId,
      'app_version': '${api_version}',
    };
    final response = await postMultipart(
      '${server_url}api/visit_dealer',
      filePath,
      headers: {
        'Content-type': 'multipart/form-data',
        "Accept": "application/json",
        "Authorization": "${token}"
      },
      formParameters: bodyFields,
      queryParameters: queryParameters,
    );
    await Future.delayed(const Duration(seconds: 1));
    return response;
  }

  Future<dynamic> offlineSchoolVisitMultipart(
      String filePath, Map<String, dynamic> bodyFields) async {
    final token = await SharedPreferencesHelper.getToken();
    print('print before token');
    print('print before token');
    String deviceId = await SharedPreferencesHelper.getDeviceId();
    print(deviceId);
    final queryParameters = {
      'device_id': deviceId,
      'app_version': '${api_version}',
    };

    final response = await postMultipart(
      '${server_url}api/offline_visit_school',
      filePath,
      headers: {
        'Content-type': 'multipart/form-data',
        "Accept": "application/json",
        "Authorization": "${token}"
      },
      formParameters: bodyFields,
      queryParameters: queryParameters,
    );
    await Future.delayed(const Duration(seconds: 1));
    print('Offline CALL API');
    print(response);
    return response;
  }

  Future<dynamic> offlineDealerVisitMultipart(
      String filePath, Map<String, dynamic> bodyFields) async {
    final token = await SharedPreferencesHelper.getToken();
    String deviceId = await SharedPreferencesHelper.getDeviceId();
    print(deviceId);
    final queryParameters = {
      'device_id': deviceId,
      'app_version': '${api_version}',
    };

    final response = await postMultipart(
      '${server_url}api/offline_visit_dealer',
      filePath,
      headers: {
        'Content-type': 'multipart/form-data',
        "Accept": "application/json",
        "Authorization": "${token}"
      },
      formParameters: bodyFields,
      queryParameters: queryParameters,
    );
    await Future.delayed(const Duration(seconds: 1));
    print('Offline CALL API');
    print(response);
    return response;
  }

  Future<dynamic> startTripMultipart(
      String filePath, Map<String, dynamic> bodyFields) async {
    final token = await SharedPreferencesHelper.getToken();
    print('print before token');
    String deviceId = await SharedPreferencesHelper.getDeviceId();
    print(deviceId);
    final queryParameters = {
      'device_id': deviceId,
      'app_version': '${api_version}',
    };
    print(token);
    final response = await postMultipart('${server_url}api/store-trip', filePath,
        headers: {
          'Content-type': 'multipart/form-data',
          "Accept": "application/json",
          "Authorization": "${token}"
        },
        formParameters: bodyFields,
        queryParameters: queryParameters,
        imageName: 'picture');
    await Future.delayed(const Duration(seconds: 1));
    print('START TRIP API');

    print(response);
    return response;
  }

  Future<dynamic> endTripMultipart(
      String filePath, Map<String, dynamic> bodyFields, String trip_id) async {
    final token = await SharedPreferencesHelper.getToken();
    print('print before token');
    String deviceId = await SharedPreferencesHelper.getDeviceId();
    print(deviceId);
    final queryParameters = {
      'device_id': deviceId,
      'app_version': '${api_version}',
    };

    final response =
        await postMultipart('${server_url}api/update-trip/${trip_id}', filePath,
            headers: {
              'Content-type': 'multipart/form-data',
              "Accept": "application/json",
              "Authorization": "${token}"
            },
            formParameters: bodyFields,
            queryParameters: queryParameters,
            imageName: 'end_picture');
    await Future.delayed(const Duration(seconds: 1));
    print('START TRIP API');

    print(response);
    return response;
  }

  Future<dynamic> trackTrip(Map<String, dynamic> bodyFields) async {
    final token = await SharedPreferencesHelper.getToken();

    var msg = jsonEncode(bodyFields);

    var response = await postFormParameters(
      '${server_url}api/tracking',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "Authorization": "${token}",
      },
      formParameters: bodyFields,
    );

    await Future.delayed(const Duration(seconds: 1));
    print('Tracking CALL API');

    return response;
  }

  Future<VisitHistoryReponse> getSchoolVisitsHistoryOnline(
      String school_id) async {
    String deviceId = await SharedPreferencesHelper.getDeviceId();
    print(deviceId);
    final queryParameters = {
      'device_id': deviceId,
      'app_version': '${api_version}',
    };

    final token = await SharedPreferencesHelper.getToken();
    final response = await get(
      "${server_url}api/school-visit-history?school_id=${school_id}",
      headers: {
        "Content-Type": "application/json",
        "Authorization": "${token}",
      },
      queryParameters: queryParameters,
    );
    await Future.delayed(const Duration(seconds: 1));
    print(response.body);

    return VisitHistoryReponse.fromJson(
      jsonDecode(response.body)['schools'],
    );
  }

  Future<DealerVisitHistoryReponse> getDealerVisitsHistoryById(
      String dealer_id) async {
    String deviceId = await SharedPreferencesHelper.getDeviceId();
    print(deviceId);
    final queryParameters = {
      'device_id': deviceId,
      'app_version': '${api_version}',
    };

    final token = await SharedPreferencesHelper.getToken();
    final response = await get(
      "${server_url}api/dealer_visit_history?dealer_id=${dealer_id}",
      headers: {
        "Content-Type": "application/json",
        "Authorization": "${token}",
      },
      queryParameters: queryParameters,
    );
    await Future.delayed(const Duration(seconds: 1));
    print(response.body);

    return DealerVisitHistoryReponse.fromJson(
      jsonDecode(response.body)['dealers'],
    );
  }

  Future<VisitHistoryReponse> getVisitedSchoolsAPI() async {
    String deviceId = await SharedPreferencesHelper.getDeviceId();
    print(deviceId);
    final queryParameters = {
      'device_id': deviceId,
      'app_version': '${api_version}',
    };

    final token = await SharedPreferencesHelper.getToken();
    final response = await get(
      "${server_url}api/visited-schools",
      headers: {
        "Content-Type": "application/json",
        "Authorization": "${token}",
      },
      queryParameters: queryParameters,
    );
    await Future.delayed(const Duration(seconds: 1));
    print(response.body);

    return VisitHistoryReponse.fromJson(
      jsonDecode(response.body)['schools'],
    );
  }

  Future<DealerVisitHistoryReponse> getVisitedDealersAPI() async {
    String deviceId = await SharedPreferencesHelper.getDeviceId();
    print(deviceId);
    final queryParameters = {
      'device_id': deviceId,
      'app_version': '${api_version}',
    };

    final token = await SharedPreferencesHelper.getToken();
    final response = await get(
      "${server_url}api/visited-dealers",
      headers: {
        "Content-Type": "application/json",
        "Authorization": "${token}",
      },
      queryParameters: queryParameters,
    );
    await Future.delayed(const Duration(seconds: 1));
    print(response.body);

    return DealerVisitHistoryReponse.fromJson(
      jsonDecode(response.body)['dealers'],
    );
  }
}
