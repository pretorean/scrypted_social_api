import 'package:scrypted_social_api/model/page.dart';
import 'package:scrypted_social_api/model/user.dart';

class PageAnswer {
  PageAnswer({
    this.id,
    this.user,
    this.title,
    this.text,
    this.createDate,
    this.type,
    this.modified,
    this.deleted,
    this.rating,
  });

  PageAnswer.fromPage(
    Page page,
    Map<String, int> rating,
  )   : createDate = page.createDate,
        deleted = page.deleted,
        id = page.id,
        modified = page.modified,
        rating = rating,
        text = page.text,
        title = page.title,
        type = page.type,
        user = page.user;

  final int id;
  final User user;
  final String title; // наименование
  final String text; // text
  final DateTime createDate; // дата создания
  final PageType type;
  final bool modified; // признак редактирования
  final bool deleted;
  final Map<String, int> rating;
}
