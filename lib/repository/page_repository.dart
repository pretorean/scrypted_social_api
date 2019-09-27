import 'package:aqueduct/aqueduct.dart';
import 'package:scrypted_social_api/model/page.dart';

class PageRepository {
  PageRepository(this.context);

  final ManagedContext context;

  Future<List<Page>> getAll() async {
    final query = Query<Page>(context)
      ..where((p) => p.deleted).equalTo(false)
      ..sortBy((p) => p.createDate, QuerySortOrder.descending);
    return query.fetch();
  }

  Future<Page> getById(int productId) async {
    final query = Query<Page>(context)
      ..where((p) => p.id).equalTo(productId)
      ..where((p) => p.deleted).equalTo(false);
    return query.fetchOne();
  }

//  Future<Product> createProduct(int companyId, Product product) async {
//    final query = Query<Product>(context)
//      ..values = product
//      ..values.company.id = companyId;
//    return query.insert();
//  }
//
//  Future<Product> setProduct(
//      int companyId, int productId, Product product) async {
//    final query = Query<Product>(context)
//      ..values = product
//      ..values.company.id = companyId
//      ..where((p) => p.id).equalTo(productId)
//      ..where((p) => p.company.id).equalTo(companyId);
//    return query.updateOne();
//  }
//
//  Future<int> softDeleteProduct(int companyId, int productId) async {
//    final query = Query<Product>(context)
//      ..values.deleted = true
//      ..where((p) => p.id).equalTo(productId)
//      ..where((p) => p.company.id).equalTo(companyId);
//    final p = await query.updateOne();
//    return p != null ? 1 : 0;
//  }
}
