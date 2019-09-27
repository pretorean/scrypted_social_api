import 'package:aqueduct/aqueduct.dart';
import 'package:scrypted_social_api/model/page.dart';
import 'package:scrypted_social_api/repository/page_repository.dart';

class PageAuthController extends ResourceController {
  PageAuthController(this.context) : repository = PageRepository(context);

  final ManagedContext context;
  final PageRepository repository;

  @Operation.post()
  Future<Response> createPage(@Bind.body() Page page) async {
    page.user.id = request.authorization.ownerID;
    final tmp = await repository.createPage(page);
    return Response.ok(tmp);
  }

  @Operation.put("editPageId")
  Future<Response> updateItem({
    @Bind.path("editPageId") int pageId,
    @Bind.body() Page page,
  }) async {
    final tmp = await repository.setPage(
      pageId,
      page,
      request.authorization.ownerID,
    );
    if (tmp == null)
      return Response.notFound();
    else
      return Response.ok(tmp);
  }

  @Operation.delete("deletePageId")
  Future<Response> deleteItem({@Bind.path("deletePageId") int pageId}) async {
    final count = await repository.softDeleteProduct(
      pageId,
      request.authorization.ownerID,
    );
    if (count == 0)
      return Response.notFound();
    else
      return Response.ok({"deleted": "$count"});
  }
}
