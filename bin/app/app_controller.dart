import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../brands/controller/brands_controller.dart';
import '../organizations/controller/organizations_controller.dart';

class AppController {
  Handler get handler {
    final router = Router();

    // Mount Other Controllers Here
    router.mount('/organizations', OrganizationsController().router);
    router.mount('/brands', BrandsController().router);

    // You can catch all verbs and use a URL-parameter with a regular expression
    // that matches everything to catch app.
    router.all('/<ignored|.*>', (Request request) {
      return Response.notFound('Page not found');
    });

    return router;
  }
}