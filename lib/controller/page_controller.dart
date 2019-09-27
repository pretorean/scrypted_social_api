import 'package:aqueduct/aqueduct.dart';
import 'package:scrypted_social_api/repository/page_repository.dart';

class PageController extends ResourceController {
  PageController(this.context, this.authServer)
      : repository = PageRepository(context);

  final ManagedContext context;
  final AuthServer authServer;
  final PageRepository repository;

  @Operation.get()
  Future<Response> getAll() async {
    final products = await repository.getAll();
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

//  @Operation.post()
//  Future<Response> createItem(
//      {@Bind.header("companyId") int companyId,
//      @Bind.body() Product product}) async {
//    if (!checkRightsByCompanyId(companyId)) {
//      return Response.forbidden();
//    }
//
//    final tmpProduct = await repository.createProduct(companyId, product);
//    return Response.ok(tmpProduct);
//  }
//
//  @Operation.put("productId")
//  Future<Response> updateItem(
//      {@Bind.path("productId") int productId,
//      @Bind.header("companyId") int companyId,
//      @Bind.body() Product product}) async {
//    if (!checkRightsByCompanyId(companyId)) {
//      return Response.forbidden();
//    }
//
//    final tmProduct =
//        await repository.setProduct(companyId, productId, product);
//    if (tmProduct == null)
//      return Response.notFound();
//    else
//      return Response.ok(product);
//  }
//
//  @Operation.delete("productId")
//  Future<Response> deleteItem(
//      {@Bind.path("productId") int productId,
//      @Bind.header("companyId") int companyId}) async {
//    if (!checkRightsByCompanyId(companyId)) {
//      return Response.forbidden();
//    }
//
//    final count = await repository.softDeleteProduct(companyId, productId);
//    if (count == 0)
//      return Response.notFound();
//    else
//      return Response.ok({"deleted": "$count"});
//  }
//
//  bool checkRightsByCompanyId(int companyId) {
//    if (companyId == null) {
//      return false;
//    }
//    return true;
//  }
}
