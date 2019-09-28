import 'package:aqueduct/aqueduct.dart';
import 'package:scrypted_social_api/model/page.dart';
import 'package:scrypted_social_api/model/user.dart';

// голоса за страницы
class RatingPage extends ManagedObject<_RatingPage> implements _RatingPage {}

@Table(name: 'rating_pages')
class _RatingPage {
  @primaryKey
  int id;

  @Relate(#ratingPages, isRequired: true, onDelete: DeleteRule.cascade)
  User user;

  @Relate(#ratingPages, isRequired: true, onDelete: DeleteRule.cascade)
  Page page;

  @Column(indexed: true)
  int rating; // рейтинг

  @Column(indexed: true)
  DateTime createDate; // дата создания
}
