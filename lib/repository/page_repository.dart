import 'package:aqueduct/aqueduct.dart';
import 'package:scrypted_social_api/model/page.dart';

class PageRepository {
  PageRepository(this.context);

  final ManagedContext context;

  Future<List<Page>> getAll() {
    final query = Query<Page>(context)
      ..where((p) => p.deleted).equalTo(false)
      ..join(set: (p) => p.ratingPages)
      ..sortBy((p) => p.createDate, QuerySortOrder.descending);
    return query.fetch();
  }

  Future<Page> getById(int productId) {
    final query = Query<Page>(context)
      ..where((p) => p.id).equalTo(productId)
      ..where((p) => p.deleted).equalTo(false);
    return query.fetchOne();
  }

  Future<Page> createPage(Page page) {
    page.createDate = DateTime.now();
    page.modified = false;
    final query = Query<Page>(context)..values = page;
    return query.insert();
  }

  Future<Page> setPage(
    int pageId,
    Page page,
    int currentUserId,
  ) async {
    page.modified = true;
    final query = Query<Page>(context)
      ..values = page
      ..where((p) => p.id).equalTo(pageId)
      ..where((p) => p.user.id).equalTo(currentUserId);
    return query.updateOne();
  }

  Future<int> softDeleteProduct(
    int pageId,
    int currentUserId,
  ) async {
    final query = Query<Page>(context)
      ..values.deleted = true
      ..where((p) => p.id).equalTo(pageId)
      ..where((p) => p.user.id).equalTo(currentUserId);
    final p = await query.updateOne();
    return p != null ? 1 : 0;
  }
}
