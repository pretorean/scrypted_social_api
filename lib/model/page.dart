import 'package:aqueduct/aqueduct.dart';
import 'package:scrypted_social_api/model/user.dart';

// Справочник "Страницы"
class Page extends ManagedObject<_Page> implements _Page {}

@Table(name: 'pages')
class _Page {
  @primaryKey
  int id;

  @Relate(#pages, isRequired: true, onDelete: DeleteRule.cascade)
  User user;

  @Column(indexed: true)
  String title; // наименование

  @Column(indexed: true)
  String text; // text

  @Column(indexed: true)
  DateTime createDate; // дата создания

  @Column(indexed: true, defaultValue: "false")
  bool deleted = false;
}
