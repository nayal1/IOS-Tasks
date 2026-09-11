void main() {
  double balance = 10000.0;
  checkBalance(
    name: "Naya",
    balance: balance,
  );
  balance = deposit(
    currentBalance: balance,
    amount: 3000.0,
  );
  balance = withdraw(
    name: "Naya",
    currentBalance: balance,
    amount: 2000.0,
    pinCode: 1234,
  );
  checkBalance(
    name: "Naya",
    balance: balance,
  );
}
void checkBalance({
  required String name,
  required double balance,
}) =>
    print("$name's current balance: $balance");
double deposit({
  required double currentBalance,
  double? amount,
}) {
  double depositAmount = amount ?? 0.0;
  double newBalance = currentBalance + depositAmount;
  print("Deposited: $depositAmount");
  print("New balance: $newBalance");
  return newBalance;
}
double withdraw({
  required String name,
  required double currentBalance,
  double? amount,
  int? pinCode,
}) {
  int pin = pinCode ?? 0000;
  double withdrawAmount = amount ?? 0.0;
  if (pin != 1234) {
    print("Incorrect PIN. Transaction declined.");
    return currentBalance;
  }
  if (withdrawAmount > currentBalance) {
    print("Insufficient funds. Transaction declined.");
    return currentBalance;
  }
  double newBalance = currentBalance - withdrawAmount;
  String userName = name!;
  print("$userName withdrew: $withdrawAmount");
  print("New balance: $newBalance");
  return newBalance;
}