import 'package:aqueduct/aqueduct.dart';
import 'package:scrypted_social_api/model/user.dart';

// пользователь системы
class UserAnswer extends Serializable {
  UserAnswer({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.midName,
    this.phone,
    this.email,
    this.subscribeNews,
    this.links,
    this.pagesCount,
  });

  UserAnswer.fromUser(User user, int pagesCount)
      : id = user.id,
        username = user.username,
        firstName = user.firstName,
        lastName = user.lastName,
        midName = user.midName,
        phone = user.phone,
        email = user.email,
        subscribeNews = user.subscribeNews,
        links = user.links,
        pagesCount = pagesCount;

  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String midName;
  final String phone;
  final String email;
  final bool subscribeNews;
  final String links;
  final int pagesCount;

  @override
  Map<String, dynamic> asMap() => {
        'id': id,
        'username': username,
        'firstName': firstName,
        'lastName': lastName,
        'midName': midName,
        'phone': phone,
        'email': email,
        'subscribeNews': subscribeNews,
        'links': links,
        'pagesCount': pagesCount,
      };

  @override
  void readFromMap(Map<String, dynamic> object) {}
}
