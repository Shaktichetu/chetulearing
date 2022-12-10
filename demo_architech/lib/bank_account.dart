import 'package:hive/hive.dart';

part 'bank_account.g.dart';

//**flutter pub run build_runner build --delete-conflicting-outputs**/
@HiveType(typeId: 1)
class BankAccount {
  BankAccount({required this.currency, required this.myMoney});
  @HiveField(0)
  String currency;

  @HiveField(1)
  int myMoney;
}
