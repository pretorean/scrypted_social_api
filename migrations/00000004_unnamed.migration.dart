import 'dart:async';
import 'package:aqueduct/aqueduct.dart';   

class Migration4 extends Migration { 
  @override
  Future upgrade() async {
   		database.addColumn("users", SchemaColumn("links", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: true, isNullable: true, isUnique: false));
		database.alterColumn("pages", "text", (c) {c.isIndexed = false;});
		database.deleteColumn("rating_pages", "text");
  }
  
  @override
  Future downgrade() async {}
  
  @override
  Future seed() async {}
}
    