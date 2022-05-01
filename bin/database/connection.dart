import 'dart:io' show Platform;

import 'package:postgres/postgres.dart';

class DB {
  late PostgreSQLConnection connection;

  DB() {
    Map<String, String> envVars = Platform.environment;
    var host = envVars["DB_HOST"] ?? "localhost";
    var port =
        envVars["DB_PORT"] == null ? 5432 : int.parse(envVars["DB_PORT"]!);
    var database = envVars["DB_DATABASE"] ?? "daria";
    var username = envVars["DB_USERNAME"] ?? "daria";
    var password = envVars["DB_PASSWORD"] ?? "";
    connection = PostgreSQLConnection(host, port, database,
        username: username, password: password);
  }
}
