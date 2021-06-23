class RequestCar {
  // final int requestId;
  // final int branchId
  // final String carModel
  // final String vehiclePreffered

  final int requestId;
  final int requestorId; // int, not object User
  final int branchId;
  final String carModel;
  final String vehiclePreffered;
  final String requestDate; //Not date; String

  final String requestStatus;
  final String approvedBy;
  final String approvedDate; //Not date; String
  final int branchRequestId;

  RequestCar(
    this.requestId,
    this.requestorId,
    this.branchId,
    this.carModel,
    this.vehiclePreffered,
    this.requestDate,
    this.requestStatus,
    this.approvedBy,
    this.approvedDate,
    this.branchRequestId,
  );

  String get getSomeInfo {
    return ("reqId: " +
        requestId.toString() +
        " who: " +
        requestorId.toString());
  }

  RequestCar.fromJson(Map<String, dynamic> json)
      : requestId = json['requestId'],
        requestorId = (json['requestorId'])['id'],
        branchId = json['branchId'],
        carModel = json['carModel'],
        vehiclePreffered = json['vehiclePreffered'],
        requestDate = json['requestDate'],
        requestStatus =
            json['requestStatus'] == null ? "no" : json['requestStatus'],
        approvedBy = json['approvedBy'] == null ? "no" : json['approvedBy'],
        approvedDate =
            json['approvedDate'] == null ? "no" : json['approvedDate'],
        branchRequestId = json['branchRequestId'];
}