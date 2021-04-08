import 'package:cli/film_api.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;


void main(List<String> arguments) async {
  final app = Router();

  app.mount('/email/', FilmApi().router);


  const corsHeaders = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE',
    'Access-Control-Allow-Headers': 'Origin, Content-Type',
  };

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(createMiddleware(
    requestHandler: (Request request) {
      if (request.method == 'OPTIONS') {
        return Response.ok('', headers: corsHeaders);
      }
      return null;
    },
    responseHandler: (Response response) {
      return response.change(headers: corsHeaders);
    },
  ))
      .addHandler(app);

  await io.serve(handler, 'localhost', 8080);
}

