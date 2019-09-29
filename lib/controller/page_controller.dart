import 'dart:html';

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
    final tmp1 = products.map(
      (p) async {
        final map = voteRepository.getPageVotes(p.id);
        return PageAnswer.fromPage(p, await map);
      },
    );

    final List<PageAnswer> tmp2 = [];
    for (Future<PageAnswer> f in tmp1) {
      tmp2.add(await f);
    }
    return Response.ok(tmp2);
  }

  @Operation.get("pageId")
  Future<Response> getById(@Bind.path("pageId") int pageId) async {
    final product = await repository.getById(pageId);
    if (product == null) return Response.notFound();

    final map = voteRepository.getPageVotes(pageId);
    final tmp = PageAnswer.fromPage(product, await map);

    return Response.ok(tmp);
  }
}
