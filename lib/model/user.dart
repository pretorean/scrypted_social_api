import 'package:aqueduct/aqueduct.dart';
import 'package:aqueduct/managed_auth.dart';
import 'package:scrypted_social_api/model/page.dart';

// тип прав в системе
enum UserType { admin, user }

// состояние пользователя в системе
enum UserState { active, banned, deleted }

// пользователь системы
class User extends ManagedObject<_User>
    implements _User, ManagedAuthResourceOwner<_User> {
  @Serialize(input: true, output: false)
  String password;
}

@Table(name: "users")
class _User extends ResourceOwnerTableDefinition {
/* This class inherits the following from ManagedAuthenticatable:

  @primaryKey
  int id;

  @Column(unique: true, indexed: true)
  String username;

  @Column(omitByDefault: true)
  String hashedPassword;

  @Column(omitByDefault: true)
  String salt;

  ManagedSet<ManagedAuthToken> tokens;
 */

  @Column(indexed: true)
  String firstName;

  @Column(indexed: true)
  String lastName;

  @Column(indexed: true, nullable: true)
  String midName;

  @Column(indexed: true, nullable: true)
  String phone;

  @Column(indexed: true, nullable: true)
  String email;

  @Column(indexed: true, defaultValue: 'false')
  bool subscribeNews;

  @Column(omitByDefault: true, indexed: true, defaultValue: "'user'")
  UserType systemRole;

  @Column(omitByDefault: true, indexed: true, defaultValue: "'active'")
  UserState state;

  ManagedSet<Page> pages;
}
