import 'package:aqueduct/aqueduct.dart';
import 'package:scrypted_social_api/model/rating_page.dart';

class VoteRepository {
  VoteRepository(this.context);

  final ManagedContext context;

  Future<int> setVote(
    int pageId,
    int vote,
    int currentUserId,
  ) async {
    final RatingPage v = RatingPage()
      ..user.id = currentUserId
      ..page.id = pageId
      ..createDate = DateTime.now()
      ..rating = vote;
    final query = Query<RatingPage>(context)..values = v;
    final p = await query.insert();
    return p != null ? 1 : 0;
  }
}
