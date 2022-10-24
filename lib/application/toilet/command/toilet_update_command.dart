import 'package:unchicchi/domain/toilet/toilet.dart';

class ToiletUpdateCommand {
  final String id;
  final int level;
  final DateTime date;

  ToiletUpdateCommand(this.id, this.level, this.date);
}
