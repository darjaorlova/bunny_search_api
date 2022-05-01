import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../dao/organizations_dao.dart';
import '../model/response/organizations_response.dart';

class OrganizationsController {
  Router get router {
    final router = Router();

    // get request to "/organizations"
    router.get('/', (Request req) async {
      final orgz = await (await organizationsDao()).getAll();
      return Response.ok(
          json.encode(OrganizationsResponse.toJson(orgz).organizations));
    });

    // catch all for "/organizations"
    router.all('/<ignored|.*>',
        (Request request) => Response.notFound('Page not found'));

    return router;
  }
}
