import 'dart:async';
import 'package:aqueduct/aqueduct.dart';

class Migration5 extends Migration {
  @override
  Future upgrade() async {
    database.addColumn(
        "pages",
        SchemaColumn("titleImg", ManagedPropertyType.string,
            isPrimaryKey: false,
            autoincrement: false,
            isIndexed: true,
            isNullable: false,
            isUnique: false),
        unencodedInitialValue: '');
  }

  @override
  Future downgrade() async {}

  @override
  Future seed() async {}
}
