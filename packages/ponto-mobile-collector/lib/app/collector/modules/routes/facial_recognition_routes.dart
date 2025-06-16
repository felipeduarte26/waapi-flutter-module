abstract class FacialRecognitionRoutes {
  static const String module = 'facial_recognition';
  static const String home = 'home';
  static const String homeFull = '$module/$home';
  static const String registration = 'registration';
  static const String registrationFull = '$module/$registration/:id';
  static const String instructions = 'instructions';
  static const String instructionsFull = '$module/$instructions';
  static const String recognition = 'recognition';
  static const String multipleRecognition = 'multiple_recognition';
  static const String recognitionFull = '$module/$recognition';
  static const String multipleRecognitionFull = '$module/$multipleRecognition';
  static const String employeeSelect = 'employee_select';
  static const String employeeSelectFull = '$module/$employeeSelect';
}
