import 'package:aqueduct/aqueduct.dart';
import 'package:scrypted_social_api/model/user.dart';

class UserController extends ResourceController {
  UserController(this.context, this.authServer);

  final ManagedContext context;
  final AuthServer authServer;

  @Operation.get("id")
  Future<Response> getUser(@Bind.path("id") int id) async {
    final query = Query<User>(context)..where((o) => o.id).equalTo(id);
    final u = await query.fetchOne();
    if (u == null) {
      return Response.notFound();
    }

    if (request.authorization.ownerID != id) {
      // Filter out stuff for non-owner of user
    }

    return Response.ok(u);
  }
}
