/// basic wrap class
base class UseCaseResult {
  final bool isSuccesful;
  final dynamic value;
  final dynamic error;

  const UseCaseResult({this.isSuccesful = false, this.value, this.error});
}
