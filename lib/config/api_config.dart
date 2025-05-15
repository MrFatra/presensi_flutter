// ignore_for_file: non_constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static String? BASEAPIURL = dotenv.env['API_BASE_URL'];
}
