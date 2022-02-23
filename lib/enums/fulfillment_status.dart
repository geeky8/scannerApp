// ignore_for_file: constant_identifier_names

enum FulFillmentStatus {
  NOTFULFILLED,
  FULFILLED,
}

extension FulfillmentStatusExtension on FulFillmentStatus {
  String inString() {
    switch (this) {
      case FulFillmentStatus.NOTFULFILLED:
        return 'NOT_FULFILLED';
      case FulFillmentStatus.FULFILLED:
        return 'FULFILLED';
    }
  }

  FulFillmentStatus status(String status) {
    switch (status) {
      case 'NOT_FULFILLED':
        return FulFillmentStatus.NOTFULFILLED;
      case 'FULFILLED':
        return FulFillmentStatus.FULFILLED;
    }
    return FulFillmentStatus.NOTFULFILLED;
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
