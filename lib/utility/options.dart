// utility/options.dart

const List<String> genderOptions = ['Male', 'Female'];
const List<String> maritalStatusOptions = ['Single', 'Divorced', 'Widowed', 'Married'];
const List<String> skinOptions = ['Fair', 'Medium', 'Dark'];
const List<String> religionOptions = ['Muslim', 'Hindu', 'Christian', 'Sikh', 'Other'];
const List<String> sectOptions = [
  'Sunni - Barelvi',
  'Sunni - Deobandi',
  'Sunni - AhleHadees',
  'Shia',
  'Other'
];
const List<String> casteOptions = [
  'Siddiquie',
  'Yousuf Zai',
  'Sindhi',
  'Punjabi',
  'Baloch',
  'Khan',
  'Other'
];

List<String> getYears() {
  return List.generate(100, (index) => (DateTime.now().year - index).toString());
}

List<String> getMonths() {
  return List.generate(12, (index) => (index + 1).toString().padLeft(2, '0'));
}

List<String> getDays(int year, int month) {
  final int daysInMonth = DateTime(year, month + 1, 0).day;
  return List.generate(daysInMonth, (index) => (index + 1).toString().padLeft(2, '0'));
}
