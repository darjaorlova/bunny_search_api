import 'package:postgres/postgres.dart';

import '../../database/connection.dart';
import '../entity/brand_entity.dart';

class BrandsDao {
  late PostgreSQLConnection connection;
  late String table;

  BrandsDao(this.connection) {
    table = "brands";
  }

  Future<void> insert(BrandEntity entity,
      {PostgreSQLExecutionContext? tx}) async {
    await (tx ?? connection).query(
        "INSERT INTO $table (brandId, title, organizationType, organizationWebsite, hasVeganProducts, logoUrl, status) VALUES (@brandId, @title, @organizationType, @organizationWebsite, @hasVeganProducts, @logoUrl, @status)",
        substitutionValues: {
          "brandId": entity.brandId,
          "title": entity.title,
          "organizationType": entity.organizationType,
          "organizationWebsite": entity.organizationWebsite,
          "hasVeganProducts": entity.hasVeganProducts,
          "logoUrl": entity.logoUrl,
          "status": entity.status,
        });
  }

  Future<void> insertAll(List<BrandEntity> entities) async {
    connection.transaction((tx) async {
      for (var entity in entities) {
        await insert(entity, tx: tx);
      }
    });
  }

  Future<void> update(
      {required String title,
      required String status,
      required String logoUrl,
      PostgreSQLExecutionContext? tx}) async {
    await (tx ?? connection).query(
        "UPDATE $table SET status=@status, logoUrl=@logoUrl WHERE title=@title",
        substitutionValues: {
          "title": title,
          "logoUrl": logoUrl,
          "status": status,
        });
  }

  Future<List<BrandEntity>> getAll() async {
    List<List<dynamic>> results =
        await connection.query("SELECT * FROM $table");

    List<BrandEntity> brands = [];

    for (final row in results) {
      brands.add(BrandEntity(
          brandId: row[1],
          title: row[2],
          organizationType: row[3],
          organizationWebsite: row[4],
          hasVeganProducts: row[5],
          logoUrl: row[6],
          status: row[7]));
    }

    return brands;
  }

  Future<List<BrandEntity>> getByType(String type) async {
    List<List<dynamic>> results = await connection.query(
        "SELECT * FROM $table WHERE organizationType=@type",
        substitutionValues: {'type': type});

    List<BrandEntity> brands = [];

    for (final row in results) {
      brands.add(BrandEntity(
          brandId: row[7],
          title: row[1],
          organizationType: row[2],
          organizationWebsite: row[3],
          hasVeganProducts: row[4],
          logoUrl: row[5],
          status: row[6]));
    }

    return brands;
  }

  Future<List<BrandEntity>> getByStatus(String status) async {
    List<List<dynamic>> results = await connection.query(
        "SELECT * FROM $table WHERE status=@status",
        substitutionValues: {'status': status});

    List<BrandEntity> brands = [];

    for (final row in results) {
      brands.add(BrandEntity(
          brandId: row[7],
          title: row[1],
          organizationType: row[2],
          organizationWebsite: row[3],
          hasVeganProducts: row[4],
          logoUrl: row[5],
          status: row[6]));
    }

    return brands;
  }
}

Future<BrandsDao> brandsDao() async {
  var db = DB();
  await db.connection.open();
  return BrandsDao(db.connection);
}
