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

  Future<int> _getPageVote(
    int pageId,
    int voteFilter,
  ) async {
    final query = Query<RatingPage>(context)
      ..where((p) => p.page.id).equalTo(pageId)
      ..where((p) => p.rating).equalTo(1);
    final tmp = await query.reduce.count();
    return tmp == null ? 0 : tmp;
  }

  Future<Map<String, int>> getPageVotes(
    int pageId,
  ) async =>
      {
        'up': await _getPageVote(pageId, 1),
        'down': await _getPageVote(pageId, -1),
      };
}
