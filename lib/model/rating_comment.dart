import 'package:aqueduct/aqueduct.dart';
import 'package:scrypted_social_api/model/comment.dart';
import 'package:scrypted_social_api/model/user.dart';

// голоса за комментарии
class RatingComment extends ManagedObject<_RatingComment>
    implements _RatingComment {}

@Table(name: 'rating_comments')
class _RatingComment {
  @primaryKey
  int id;

  @Relate(#ratingComments, isRequired: true, onDelete: DeleteRule.cascade)
  User user;

  @Relate(#ratingComments, isRequired: true, onDelete: DeleteRule.cascade)
  Comment comment;

  @Column(indexed: true)
  String text; // text

  @Column(indexed: true)
  int rating; // рейтинг

  @Column(indexed: true)
  DateTime createDate; // дата создания
}
