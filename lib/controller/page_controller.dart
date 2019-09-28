import 'package:aqueduct/aqueduct.dart';
import 'package:scrypted_social_api/model/page.dart';
import 'package:scrypted_social_api/repository/answer/page_answer.dart';
import 'package:scrypted_social_api/repository/page_repository.dart';
import 'package:scrypted_social_api/repository/vote_repository.dart';

class PageController extends ResourceController {
  PageController(this.context)
      : repository = PageRepository(context),
        voteRepository = VoteRepository(context);

  final ManagedContext context;
  final PageRepository repository;
  final VoteRepository voteRepository;

  @Operation.get()
  Future<Response> getAll() async {
    final List<Page> products = await repository.getAll();
//    final List<PageAnswer> tmp = products.map(
//      (p) {
//        final map =
//            voteRepository.getPageVotes(p.id, request.authorization.ownerID);
//        return PageAnswer.fromPage(p, map);
//      },
//    ).toList();
    return Response.ok(products);
  }

  @Operation.get("pageId")
  Future<Response> getById(@Bind.path("pageId") int pageId) async {
    final product = await repository.getById(pageId);
    if (product == null)
      return Response.notFound();
    else
      return Response.ok(product);
  }
}
