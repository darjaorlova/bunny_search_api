import 'package:postgres/postgres.dart';

import '../../database/connection.dart';
import '../entity/organization_entity.dart';

class OrganizationsDao {
  late PostgreSQLConnection connection;
  late String table;

  OrganizationsDao(this.connection) {
    table = "organizations";
  }

  Future<void> insert(OrganisationEntity entity,
      {PostgreSQLExecutionContext? tx}) async {
    await (tx ?? connection).query(
        "INSERT INTO $table (orgId, title, brandsCount, website) VALUES (@orgId, @title, @brandsCount, @website)",
        substitutionValues: {
          "orgId": entity.orgId,
          "title": entity.title,
          "brandsCount": entity.brandsCount,
          "website": entity.website,
        });
  }

  Future<void> insertAll(List<OrganisationEntity> entities) async {
    connection.transaction((tx) async {
      for (var entity in entities) {
        await insert(entity, tx: tx);
      }
    });
  }

  Future<List<OrganisationEntity>> getAll() async {
    List<List<dynamic>> results =
        await connection.query("SELECT * FROM $table");

    List<OrganisationEntity> organizations = [];

    for (final row in results) {
      organizations.add(OrganisationEntity(
          orgId: row[1], title: row[2], brandsCount: row[3], website: row[4]));
    }

    return organizations;
  }
}

Future<OrganizationsDao> organizationsDao() async {
  var db = DB();
  await db.connection.open();
  return OrganizationsDao(db.connection);
}
