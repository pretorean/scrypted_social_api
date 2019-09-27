import 'package:aqueduct/aqueduct.dart';
import 'package:scrypted_social_api/model/page.dart';
import 'package:scrypted_social_api/model/rating_comment.dart';
import 'package:scrypted_social_api/model/user.dart';

// Справочник "Комментарии"
class Comment extends ManagedObject<_Comment> implements _Comment {}

@Table(name: 'comments')
class _Comment {
  @primaryKey
  int id;

  @Relate(#comments, isRequired: true, onDelete: DeleteRule.cascade)
  User user;

  @Relate(#comments, isRequired: true, onDelete: DeleteRule.cascade)
  Page page;

  @Column(indexed: true)
  String text; // text

  @Column(indexed: true)
  DateTime createDate; // дата создания

  @Column(indexed: true, defaultValue: "false")
  bool deleted = false;

  ManagedSet<RatingComment> ratingComments;
}
