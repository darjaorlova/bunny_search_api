import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../dao/brands_dao.dart';
import '../model/response/brands_response.dart';

class BrandsController {
  Router get router {
    final router = Router();

    // get request to "/brands"
    router.get('/', (Request req) async {
      final params = req.url.queryParameters;
      final type = params['type'] ?? '';
      final status = params['status'];
      final dao = await brandsDao();
      final brands = status != null
          ? await dao.getByStatus(status)
          : await dao.getByType(type);
      return Response.ok(json.encode(BrandsResponse.toJson(brands).brands));
    });

    // catch all for "/brands"
    router.all('/<ignored|.*>',
        (Request request) {
          return Response.notFound('Page not found');});

    return router;
  }
}
