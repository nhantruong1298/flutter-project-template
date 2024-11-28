// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';

enum BusinessExceptionCode {
  UNEXPECTED_ERROR,
  REQUEST_TIME_OUT,
  NETWORK_ERROR,
  UNAUTHORIZED,
  INVALID_OTP,
  INVALID_OTP_CODE,
  MAX_RETRIES_EXCEEDED,
  INVALID_LOGIN_INFO,
  INVALID_SERVER_CONFIG,
  ACCOUNT_TEMPORARY_LOCKED,

  BIOMETRIC_NOT_ENROLL,
  BIOMETRIC_NOT_SUPPORT,
  BIOMETRIC_NOT_AVAILABLE,
  BIOMETRIC_AUTH_LOCKOUT,
  BIOMETRIC_DATA_MODIFIED,
  BIOMETRIC_IGNORE_ERROR,
  BIOMETRIC_AUTH_FAILED,

  USER_NOT_FOUND,

  EMAIL_NOT_CONFIRMED,
  FAILED_LAUNCH_EMAIL,
  FAILED_LAUNCH_SMS,
  FAILED_LAUNCH_URL,
  PASSWORD_INVALID,
  DUPLICATE_USER_NAME,
  IMAGE_PICKER_NO_CAMERA_AVAILABLE,
  IMAGE_PICKER_CAMERA_ACCESS_DENIED,
  IMAGE_PICKER_PHOTO_ACCESS_DENIED,
  ONFIDO_CREATE_CHECK_ERROR,
  NEW_PASSWORD_INVALID,

  // API side error code
  NotFoundAppointmentId, //1100
  NotAllowCancelAppointment, //1101
  NotAllowUpdateAppointment, //1102
  NotAllowReviewAppointment, //1103
  NotFoundPatientId, //1200
  NotAllowUpdatePatient, //1201
  OverlappedSchedule, //1202
  NotFoundPhysicianId, //1300
  BookingValidationFailed, //1001
  OverlappedPatientSchedule, //1104
  NotAllowConfirmBilling, //1801
  CardInsufficientFunds, //1705
  NotAllowPayAppointment, //1111
  AttachDuplicatedPaymentMethod, //1808
  OtpNotMatched, //1403
  PatientPhoneNumberInvalid, //1207
  OtpExpired, //1402
  ZoomStatusInActive, //2600
  InvalidPhoneNumber, //1000

  RegisterTokenFailed, //1002

  NotFoundAnswerId, //1500

  InvalidPassword, // 1406

  ;

  static BusinessExceptionCode parse(String? code) {
    switch (code) {
      case '1001':
        return BusinessExceptionCode.BookingValidationFailed;
      case '1100':
        return BusinessExceptionCode.NotFoundAppointmentId;
      case '1102':
        return BusinessExceptionCode.NotAllowCancelAppointment;
      case '1103':
        return BusinessExceptionCode.NotAllowReviewAppointment;
      case '1111':
        return BusinessExceptionCode.NotAllowPayAppointment;
      case '1200':
        return BusinessExceptionCode.NotFoundPatientId;

      case '1201':
        return BusinessExceptionCode.NotAllowUpdatePatient;
      case '1202':
        return BusinessExceptionCode.OverlappedSchedule;
      case '1300':
        return BusinessExceptionCode.NotFoundPhysicianId;
      case '1104':
      case '1105':
        return BusinessExceptionCode.OverlappedPatientSchedule;
      case '1801':
        return BusinessExceptionCode.NotAllowConfirmBilling;
      case '1705':
        return BusinessExceptionCode.CardInsufficientFunds;
      case '1808':
        return BusinessExceptionCode.AttachDuplicatedPaymentMethod;
      case '1403':
        return BusinessExceptionCode.OtpNotMatched;
      case '1402':
        return BusinessExceptionCode.OtpExpired;
      case '1207':
        return BusinessExceptionCode.PatientPhoneNumberInvalid;
      case '2600':
        return BusinessExceptionCode.ZoomStatusInActive;
      case '1000':
        return BusinessExceptionCode.InvalidPhoneNumber;
      case '1002':
        return BusinessExceptionCode.RegisterTokenFailed;
      case '1500':
        return BusinessExceptionCode.NotFoundAnswerId;
      case '1406':
        return BusinessExceptionCode.InvalidPassword;
      default:
        return BusinessExceptionCode.UNEXPECTED_ERROR;
    }
  }

  String get value => describeEnum(this);
}
