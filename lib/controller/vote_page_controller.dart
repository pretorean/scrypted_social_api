import 'package:aqueduct/aqueduct.dart';
import 'package:scrypted_social_api/repository/vote_repository.dart';

class VotePageController extends ResourceController {
  VotePageController(this.context) : repository = VoteRepository(context);

  final ManagedContext context;
  final VoteRepository repository;

  @Operation.post("pageId", "vote")
  Future<Response> createPage(
    @Bind.path("pageId") int pageId,
    @Bind.path("vote") int vote,
  ) async {
    if (![0, 1].contains(vote)) {
      return Response.badRequest();
    }

    final count = await repository.setVote(
      pageId,
      vote - 1,
      request.authorization.ownerID,
    );
    if (count == 0)
      return Response.notFound();
    else
      return Response.ok({"voted": "$count"});
  }
}
