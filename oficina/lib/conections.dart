import 'package:postgres/postgres.dart';

var databaseConections = PostgreSQLConnection(host, 5432, myteste,
    queryTimeoutInSeconds: 3600,
    timeoutInSeconds: 3600,
    username: username,
    password: password);

