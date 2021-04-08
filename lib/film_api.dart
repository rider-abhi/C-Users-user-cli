import 'dart:io';
import 'dart:convert';

import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';

class FilmApi {
  final List data = json.decode(File('cred.json').readAsStringSync());

  Router get router {
    final router = Router();

    // router.get('/', (Request request) {
    //   return Response.ok(json.encode(data),
    //       headers: {'Content-Type': 'application/json'});
    // });

    router.get('/<email|.*>', (Request request, String email) {
      final film =
          data.firstWhere((film) => film['email'] == email, orElse: () => null);

      if (film != null) {
        return Response.ok(
          'Successfully validated',
        );
      } else {
        return Response.notFound('Email not found');
      }
    });

    // router.post('/', (Request request) async {
    //   final payload = await request.readAsString();
    //   data.add(json.decode(payload));
    //   return Response.ok(payload,
    //       headers: {'Content-Type': 'application/json'});
    // });

    // router.delete('/<email>', (Request request, String id) {
    //   final parsedId = int.tryParse(id);
    //   data.removeWhere((film) => film['email'] == parsedId);
    //   return Response.ok('Deleted.');
    // });

    return router;
  }
}
