void main() {
  int digit = 5;
  print("1st Task");
  print("MULTIPLICATION TABLE for digit $digit");
  for (int i = 1; i <= 10; i++) {
    print("$digit * $i = ${i * digit}");
  }

  String d1 = "31.12.2026";
  String d2 = "28.02.2025";
  String d3 = "28.02.2024";
  String d4 = "28.02.2100";
  List<String> parts = d1.split('.');
  int day = int.parse(parts[0]);
  int month = int.parse(parts[1]);
  int year = int.parse(parts[2]);
  int day_month(int month, int year) {
    if (month == 2) {
      bool isLeap = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
      return isLeap ? 29 : 28;
    }
    if (month == 4 || month == 6 || month == 9 || month == 11) {
      return 30;
    }
    return 31;
  }
  int count_day = day_month(month, year);
  day++;
  if (day > count_day) {
    day = 1;
    month++;
  }
  if (month > 12) {
    month = 1;
    year++;
  }
  print("\n2nd Task");
  print("Tomorrow is $day.$month.$year");

  String message = "flutter mobile development";
  int n = 0;
  for (int i = 0; i < message.length; i++) {
    if ("euioa".contains(message[i])) {
      n++;
    }
  }
  print("\n3rd Task");
  print("Vowel count: $n");

  List<int> numbers = [14, 88, 3, 42, 99, 12, 67]; //-> max: 99, min: 3
  List<int> numbers1 = [234, 34, 123, 44, 949, 112, 67]; //-> max: 949, min: 34
  int max = numbers1[0]; 
  int min = numbers1[0];
  for (int num in numbers1) {
    if (num > max) {
      max = num;
    }
    if (num < min) {
      min = num;
    }
  }
  print("\n4th Task");
  print("Max number: $max;\nMin number: $min");

  int numb = 7;
  bool isPrime = true;
  if (numb < 2) { 
    isPrime = false; 
  } 
  for (int i = 2; i < numb; i++) { 
    if (numb % i == 0) { 
      isPrime = false; 
    } 
  }
  print("\n5th Task");
  if (isPrime) {
    print("$numb is Prime");
  } else {
    print("$numb is not Prime");
  }
}