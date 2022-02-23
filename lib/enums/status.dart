// ignore_for_file: constant_identifier_names

enum Status {
  NEW,
  PENDING,
  COMPLETED,
}

extension StatusExtension on Status {
  String inString() {
    switch (this) {
      case Status.NEW:
        return "new";
      case Status.PENDING:
        return "pending";
      case Status.COMPLETED:
        return "completed";
    }
  }

  Status status(String status) {
    switch (status) {
      case 'new':
        return Status.NEW;
      case 'pending':
        return Status.PENDING;
      case 'completed':
        return Status.COMPLETED;
    }
    return Status.NEW;
  }
}

// FulFillmentStatus fulFillmentStatus(String status) {
//   switch (status) {
//     case 'NOT_FULFILLED':
//       return FulFillmentStatus.NOTFULFILLED;
//     case 'FULFILLED':
//       return FulFillmentStatus.FULFILLED;
//   }
//   return FulFillmentStatus.NOTFULFILLED;
// }
