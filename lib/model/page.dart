import 'package:aqueduct/aqueduct.dart';
import 'package:scrypted_social_api/model/comment.dart';
import 'package:scrypted_social_api/model/rating_page.dart';
import 'package:scrypted_social_api/model/user.dart';

// тип страницы
enum PageType { page, report, story }

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
  String titleImg;

  @Column(indexed: false)
  String text; // text

  @Column(indexed: true)
  DateTime createDate; // дата создания

  @Column(indexed: true, defaultValue: "'page'")
  PageType type;

  @Column(defaultValue: "false")
  bool modified; // признак редактирования

  @Column(indexed: true, defaultValue: "false")
  bool deleted = false;

  ManagedSet<Comment> comments;
  ManagedSet<RatingPage> ratingPages;
}
