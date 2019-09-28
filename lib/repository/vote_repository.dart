import 'package:aqueduct/aqueduct.dart';
import 'package:scrypted_social_api/model/page.dart';
import 'package:scrypted_social_api/model/rating_page.dart';
import 'package:scrypted_social_api/model/user.dart';

class VoteRepository {
  VoteRepository(this.context);

  final ManagedContext context;

  Future<int> setVote(
    int pageId,
    int vote,
    int currentUserId,
  ) async {
    final tmpUser = User()..id = currentUserId;
    final tmpPage = Page()..id = pageId;

    final checkQuery = Query<RatingPage>(context)
      ..where((p) => p.user.id).equalTo(currentUserId)
      ..where((p) => p.page.id).equalTo(pageId);
    final count = await checkQuery.reduce.count();

    if (count != null && count > 0) {
      return 0;
    }

    final RatingPage v = RatingPage()
      ..user = tmpUser
      ..page = tmpPage
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
      ..where((p) => p.rating).equalTo(voteFilter);
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
