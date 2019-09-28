import 'package:aqueduct/aqueduct.dart';
import 'package:aqueduct/managed_auth.dart';
import 'package:scrypted_social_api/controller/identity_controller.dart';
import 'package:scrypted_social_api/controller/page_auth_controller.dart';
import 'package:scrypted_social_api/controller/page_controller.dart';
import 'package:scrypted_social_api/controller/register_controller.dart';
import 'package:scrypted_social_api/controller/user_auth_controller.dart';
import 'package:scrypted_social_api/controller/user_controller.dart';
import 'package:scrypted_social_api/controller/vote_page_controller.dart';
import 'package:scrypted_social_api/model/user.dart';
import 'package:scrypted_social_api/scrypted_social_api.dart';
import 'package:scrypted_social_api/utility/html_template.dart';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class ScryptedSocialApiChannel extends ApplicationChannel
    implements AuthRedirectControllerDelegate {
  final HTMLRenderer htmlRenderer = HTMLRenderer();
  AuthServer authServer;
  ManagedContext context;

  /// Initialize services in this method.
  ///
  /// Implement this method to initialize services, read values from [options]
  /// and any other initialization required before constructing [entryPoint].
  ///
  /// This method is invoked prior to [entryPoint] being accessed.
  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final config =
        ScryptedSocialApiConfiguration(options.configurationFilePath);

    context = contextWithConnectionInfo(config.database);

    final authStorage = ManagedAuthDelegate<User>(context);
    authServer = AuthServer(authStorage);

    CORSPolicy.defaultPolicy.allowedOrigins = [
      'XN--90ACIBPMTAD6AL5FSD.XN--P1AI',
    ];
  }

  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint {
    final router = Router();

    /* OAuth 2.0 Endpoints */
    router.route("/auth/token").link(() => AuthController(authServer));

    router
        .route("/auth/form")
        .link(() => AuthRedirectController(authServer, delegate: this));

    /* Create an account */
    router
        .route("/register")
        .link(() => Authorizer.basic(authServer))
        .link(() => RegisterController(context, authServer));

    /* Gets profile for user with bearer token */
    router
        .route("/me")
        .link(() => Authorizer.bearer(authServer))
        .link(() => IdentityController(context));

    /* Gets all users or one specific user by id */
    router
        .route("/users/[:id]")
        .link(() => Authorizer.bearer(authServer))
        .link(() => UserAuthController(context, authServer));

    // запрос без авторизации
    router.route("/user/:id").link(() => UserController(context, authServer));

    // страницы просмотр
    router.route("/page/[:pageId]").link(() => PageController(context));

    // страницы создание
    router
        .route("/newpage")
        .link(() => Authorizer.bearer(authServer))
        .link(() => PageAuthController(context));

    // страницы редактирование
    router
        .route("/page/edit/:editPageId")
        .link(() => Authorizer.bearer(authServer))
        .link(() => PageAuthController(context));

    // страницы удаление
    router
        .route("/page/delete/:deletePageId")
        .link(() => Authorizer.bearer(authServer))
        .link(() => PageAuthController(context));

    // голоса страниц
    router
        .route("/vote/:pageId/:vote")
        .link(() => Authorizer.bearer(authServer))
        .link(() => VotePageController(context));

    return router;
  }

  /*
   * Helper methods
   */

  ManagedContext contextWithConnectionInfo(
      DatabaseConfiguration connectionInfo) {
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final psc = PostgreSQLPersistentStore(
        connectionInfo.username,
        connectionInfo.password,
        connectionInfo.host,
        connectionInfo.port,
        connectionInfo.databaseName);

    return ManagedContext(dataModel, psc);
  }

  @override
  Future<String> render(AuthRedirectController forController, Uri requestUri,
      String responseType, String clientID, String state, String scope) async {
    final map = {
      "response_type": responseType,
      "client_id": clientID,
      "state": state
    };

    map["path"] = requestUri.path;
    if (scope != null) {
      map["scope"] = scope;
    }

    return htmlRenderer.renderHTML("web/login.html", map);
  }
}

/// An instance of this class represents values from a configuration
/// file specific to this application.
///
/// Configuration files must have key-value for the properties in this class.
/// For more documentation on configuration files, see
/// https://pub.dartlang.org/packages/safe_config.
class ScryptedSocialApiConfiguration extends Configuration {
  ScryptedSocialApiConfiguration(String fileName)
      : super.fromFile(File(fileName));

  DatabaseConfiguration database;
}
