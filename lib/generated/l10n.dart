// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Continue`
  String get conttinue {
    return Intl.message('Continue', name: 'conttinue', desc: '', args: []);
  }

  /// `Finish`
  String get finish {
    return Intl.message('Finish', name: 'finish', desc: '', args: []);
  }

  /// `Join Our Network of Healthcare Providers`
  String get onBoarding1Title {
    return Intl.message(
      'Join Our Network of Healthcare Providers',
      name: 'onBoarding1Title',
      desc: '',
      args: [],
    );
  }

  /// `Offer your medical services at home and connect with patients easily.`
  String get onBoarding1description {
    return Intl.message(
      'Offer your medical services at home and connect with patients easily.',
      name: 'onBoarding1description',
      desc: '',
      args: [],
    );
  }

  /// `Easy Home Visits & Medical Services`
  String get onBoarding2Title {
    return Intl.message(
      'Easy Home Visits & Medical Services',
      name: 'onBoarding2Title',
      desc: '',
      args: [],
    );
  }

  /// `Manage appointments, visit patients, and get paid—all in one app.`
  String get onBoarding2description {
    return Intl.message(
      'Manage appointments, visit patients, and get paid—all in one app.',
      name: 'onBoarding2description',
      desc: '',
      args: [],
    );
  }

  /// `Start Accepting Home Visit Requests Today!`
  String get onBoarding3Title {
    return Intl.message(
      'Start Accepting Home Visit Requests Today!',
      name: 'onBoarding3Title',
      desc: '',
      args: [],
    );
  }

  /// `Sign up, verify your details, and start accepting home visit requests.`
  String get onBoarding3description {
    return Intl.message(
      'Sign up, verify your details, and start accepting home visit requests.',
      name: 'onBoarding3description',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back`
  String get loginTitle {
    return Intl.message('Welcome Back', name: 'loginTitle', desc: '', args: []);
  }

  /// `Please enter your email`
  String get embtyEmailWarning {
    return Intl.message(
      'Please enter your email',
      name: 'embtyEmailWarning',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get inValidMailWarning {
    return Intl.message(
      'Please enter a valid email',
      name: 'inValidMailWarning',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get Password {
    return Intl.message('Password', name: 'Password', desc: '', args: []);
  }

  /// `Please enter your email`
  String get embtyPasswordWarning {
    return Intl.message(
      'Please enter your email',
      name: 'embtyPasswordWarning',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters long`
  String get shortPasswordWarning {
    return Intl.message(
      'Password must be at least 6 characters long',
      name: 'shortPasswordWarning',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password`
  String get ForgetPassword {
    return Intl.message(
      'Forget Password',
      name: 'ForgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `or login with`
  String get orLoginWith {
    return Intl.message(
      'or login with',
      name: 'orLoginWith',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUp {
    return Intl.message('Sign up', name: 'signUp', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Enter your email to reset your password.`
  String get forgetPasswordInfo {
    return Intl.message(
      'Enter your email to reset your password.',
      name: 'forgetPasswordInfo',
      desc: '',
      args: [],
    );
  }

  /// `Send Reset Link`
  String get sendCode {
    return Intl.message(
      'Send Reset Link',
      name: 'sendCode',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code`
  String get resendCode {
    return Intl.message('Resend Code', name: 'resendCode', desc: '', args: []);
  }

  /// `Reset link has been sent, please enter the OTP Numbers here to continue.`
  String get otpInfo {
    return Intl.message(
      'Reset link has been sent, please enter the OTP Numbers here to continue.',
      name: 'otpInfo',
      desc: '',
      args: [],
    );
  }

  /// `Didn’t receive an email? `
  String get didnotReciveEmail {
    return Intl.message(
      'Didn’t receive an email? ',
      name: 'didnotReciveEmail',
      desc: '',
      args: [],
    );
  }

  /// `Create a new password`
  String get newPasswordInfo {
    return Intl.message(
      'Create a new password',
      name: 'newPasswordInfo',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confermation Password`
  String get confermationPassword {
    return Intl.message(
      'Confermation Password',
      name: 'confermationPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password must be like Confermation Password`
  String get confermationPasswordError {
    return Intl.message(
      'Password must be like Confermation Password',
      name: 'confermationPasswordError',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message('First Name', name: 'firstName', desc: '', args: []);
  }

  /// `Last Name`
  String get lastName {
    return Intl.message('Last Name', name: 'lastName', desc: '', args: []);
  }

  /// `Phone Number`
  String get phone {
    return Intl.message('Phone Number', name: 'phone', desc: '', args: []);
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `Join to us now!`
  String get joinUs {
    return Intl.message('Join to us now!', name: 'joinUs', desc: '', args: []);
  }

  /// `Please enter your first name`
  String get embtyFirstnameWarning {
    return Intl.message(
      'Please enter your first name',
      name: 'embtyFirstnameWarning',
      desc: '',
      args: [],
    );
  }

  /// `First name must be at least 3 characters long`
  String get shortFirstnameWarning {
    return Intl.message(
      'First name must be at least 3 characters long',
      name: 'shortFirstnameWarning',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your Last name`
  String get embtyLastnameWarning {
    return Intl.message(
      'Please enter your Last name',
      name: 'embtyLastnameWarning',
      desc: '',
      args: [],
    );
  }

  /// `Last name must be at least 3 characters long`
  String get shortLastnameWarning {
    return Intl.message(
      'Last name must be at least 3 characters long',
      name: 'shortLastnameWarning',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your address`
  String get embtyAddressWarning {
    return Intl.message(
      'Please enter your address',
      name: 'embtyAddressWarning',
      desc: '',
      args: [],
    );
  }

  /// `Address must be at least 12 characters long`
  String get shortAddressWarning {
    return Intl.message(
      'Address must be at least 12 characters long',
      name: 'shortAddressWarning',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your Phone number`
  String get embtyPhoneWarning {
    return Intl.message(
      'Please enter your Phone number',
      name: 'embtyPhoneWarning',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number must be at least 11 Numbers long`
  String get shortPhoneWarning {
    return Intl.message(
      'Phone Number must be at least 11 Numbers long',
      name: 'shortPhoneWarning',
      desc: '',
      args: [],
    );
  }

  /// `or signup with`
  String get signUpWith {
    return Intl.message(
      'or signup with',
      name: 'signUpWith',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? `
  String get haveAccount {
    return Intl.message(
      'Already have an account? ',
      name: 'haveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Organizational`
  String get organizational {
    return Intl.message(
      'Organizational',
      name: 'organizational',
      desc: '',
      args: [],
    );
  }

  /// `Individual`
  String get individual {
    return Intl.message('Individual', name: 'individual', desc: '', args: []);
  }

  /// `Please select your user type`
  String get userTypeWarning {
    return Intl.message(
      'Please select your user type',
      name: 'userTypeWarning',
      desc: '',
      args: [],
    );
  }

  /// `User Type`
  String get userType {
    return Intl.message('User Type', name: 'userType', desc: '', args: []);
  }

  /// `Select User Type`
  String get selectUserType {
    return Intl.message(
      'Select User Type',
      name: 'selectUserType',
      desc: '',
      args: [],
    );
  }

  /// `Upload Required Documents`
  String get uploadRequiredDocuments {
    return Intl.message(
      'Upload Required Documents',
      name: 'uploadRequiredDocuments',
      desc: '',
      args: [],
    );
  }

  /// `Upload Here`
  String get uploadHere {
    return Intl.message('Upload Here', name: 'uploadHere', desc: '', args: []);
  }

  /// `Upload Documents`
  String get uploadDocuments {
    return Intl.message(
      'Upload Documents',
      name: 'uploadDocuments',
      desc: '',
      args: [],
    );
  }

  /// `You Can Track Your Documents Status Here`
  String get documentsReviewDescription {
    return Intl.message(
      'You Can Track Your Documents Status Here',
      name: 'documentsReviewDescription',
      desc: '',
      args: [],
    );
  }

  /// `Under Review`
  String get underReview {
    return Intl.message(
      'Under Review',
      name: 'underReview',
      desc: '',
      args: [],
    );
  }

  /// `Approved`
  String get approved {
    return Intl.message('Approved', name: 'approved', desc: '', args: []);
  }

  /// `Rejected`
  String get rejected {
    return Intl.message('Rejected', name: 'rejected', desc: '', args: []);
  }

  /// `Documents`
  String get documents {
    return Intl.message('Documents', name: 'documents', desc: '', args: []);
  }

  /// `National ID`
  String get nationalId {
    return Intl.message('National ID', name: 'nationalId', desc: '', args: []);
  }

  /// `Please enter your National ID`
  String get nationalIdEmbtyWarning {
    return Intl.message(
      'Please enter your National ID',
      name: 'nationalIdEmbtyWarning',
      desc: '',
      args: [],
    );
  }

  /// `National ID must be at least 14 characters long`
  String get nationalIdShortWarning {
    return Intl.message(
      'National ID must be at least 14 characters long',
      name: 'nationalIdShortWarning',
      desc: '',
      args: [],
    );
  }

  /// `male`
  String get male {
    return Intl.message('male', name: 'male', desc: '', args: []);
  }

  /// `female`
  String get female {
    return Intl.message('female', name: 'female', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Requests`
  String get requests {
    return Intl.message('Requests', name: 'requests', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Language changed successfully`
  String get languageChangedSuccessfully {
    return Intl.message(
      'Language changed successfully',
      name: 'languageChangedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Language changed failed please try again`
  String get languageChangedFailed {
    return Intl.message(
      'Language changed failed please try again',
      name: 'languageChangedFailed',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `General`
  String get general {
    return Intl.message('General', name: 'general', desc: '', args: []);
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Insurance`
  String get insurance {
    return Intl.message('Insurance', name: 'insurance', desc: '', args: []);
  }

  /// `Manage Cards`
  String get manageCards {
    return Intl.message(
      'Manage Cards',
      name: 'manageCards',
      desc: '',
      args: [],
    );
  }

  /// `Help & Support`
  String get helpAndSupport {
    return Intl.message(
      'Help & Support',
      name: 'helpAndSupport',
      desc: '',
      args: [],
    );
  }

  /// `Email Us`
  String get emailUs {
    return Intl.message('Email Us', name: 'emailUs', desc: '', args: []);
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message('Contact Us', name: 'contactUs', desc: '', args: []);
  }

  /// `Additional Settings`
  String get additionalSettings {
    return Intl.message(
      'Additional Settings',
      name: 'additionalSettings',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Rate Us`
  String get rateUs {
    return Intl.message('Rate Us', name: 'rateUs', desc: '', args: []);
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Old Password`
  String get oldPassword {
    return Intl.message(
      'Old Password',
      name: 'oldPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully`
  String get passwordChangedSuccessfully {
    return Intl.message(
      'Password changed successfully',
      name: 'passwordChangedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Analytics`
  String get analytics {
    return Intl.message('Analytics', name: 'analytics', desc: '', args: []);
  }

  /// `Feedback`
  String get feedback {
    return Intl.message('Feedback', name: 'feedback', desc: '', args: []);
  }

  /// `Complaints`
  String get complaints {
    return Intl.message('Complaints', name: 'complaints', desc: '', args: []);
  }

  /// `Hello Dr,`
  String get hello {
    return Intl.message('Hello Dr,', name: 'hello', desc: '', args: []);
  }

  /// `Welcome back`
  String get welcomeBack {
    return Intl.message(
      'Welcome back',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Sehetna App`
  String get welcomeToSehetnaApp {
    return Intl.message(
      'Welcome to Sehetna App',
      name: 'welcomeToSehetnaApp',
      desc: '',
      args: [],
    );
  }

  /// `ready to receive requests`
  String get readyToReceiveRequests {
    return Intl.message(
      'ready to receive requests',
      name: 'readyToReceiveRequests',
      desc: '',
      args: [],
    );
  }

  /// `Accept home visits and nursing care requests from nearby patients.`
  String get homeContainerDescription {
    return Intl.message(
      'Accept home visits and nursing care requests from nearby patients.',
      name: 'homeContainerDescription',
      desc: '',
      args: [],
    );
  }

  /// `Provider Stats`
  String get providerStats {
    return Intl.message(
      'Provider Stats',
      name: 'providerStats',
      desc: '',
      args: [],
    );
  }

  /// `Today revenue`
  String get todayGain {
    return Intl.message('Today revenue', name: 'todayGain', desc: '', args: []);
  }

  /// `Provider Gain`
  String get providerGain {
    return Intl.message(
      'Provider Gain',
      name: 'providerGain',
      desc: '',
      args: [],
    );
  }

  /// `Sehetna Gain`
  String get sehetnaGain {
    return Intl.message(
      'Sehetna Gain',
      name: 'sehetnaGain',
      desc: '',
      args: [],
    );
  }

  /// `Ongoing Request`
  String get ongoingRequests {
    return Intl.message(
      'Ongoing Request',
      name: 'ongoingRequests',
      desc: '',
      args: [],
    );
  }

  /// `show Details`
  String get showDetails {
    return Intl.message(
      'show Details',
      name: 'showDetails',
      desc: '',
      args: [],
    );
  }

  /// `Response`
  String get responseTitle {
    return Intl.message('Response', name: 'responseTitle', desc: '', args: []);
  }

  /// `No response yet`
  String get noResponseText {
    return Intl.message(
      'No response yet',
      name: 'noResponseText',
      desc: '',
      args: [],
    );
  }

  /// `Resolved`
  String get statusResolved {
    return Intl.message('Resolved', name: 'statusResolved', desc: '', args: []);
  }

  /// `Closed`
  String get statusClosed {
    return Intl.message('Closed', name: 'statusClosed', desc: '', args: []);
  }

  /// `Open`
  String get statusOpen {
    return Intl.message('Open', name: 'statusOpen', desc: '', args: []);
  }

  /// `In Progress`
  String get statusInProgress {
    return Intl.message(
      'In Progress',
      name: 'statusInProgress',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get statusPending {
    return Intl.message('Pending', name: 'statusPending', desc: '', args: []);
  }

  /// `No Subject`
  String get noSubjectText {
    return Intl.message(
      'No Subject',
      name: 'noSubjectText',
      desc: '',
      args: [],
    );
  }

  /// `No description provided`
  String get noDescriptionText {
    return Intl.message(
      'No description provided',
      name: 'noDescriptionText',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message('History', name: 'history', desc: '', args: []);
  }

  /// `Request Details`
  String get requestDetails {
    return Intl.message(
      'Request Details',
      name: 'requestDetails',
      desc: '',
      args: [],
    );
  }

  /// `Patient`
  String get patient {
    return Intl.message('Patient', name: 'patient', desc: '', args: []);
  }

  /// `Date`
  String get date {
    return Intl.message('Date', name: 'date', desc: '', args: []);
  }

  /// `Service type`
  String get serviceType {
    return Intl.message(
      'Service type',
      name: 'serviceType',
      desc: '',
      args: [],
    );
  }

  /// `Total Fees`
  String get totalFees {
    return Intl.message('Total Fees', name: 'totalFees', desc: '', args: []);
  }

  /// `Call Patient`
  String get callPatient {
    return Intl.message(
      'Call Patient',
      name: 'callPatient',
      desc: '',
      args: [],
    );
  }

  /// `Complaint`
  String get complaint {
    return Intl.message('Complaint', name: 'complaint', desc: '', args: []);
  }

  /// `Location`
  String get location {
    return Intl.message('Location', name: 'location', desc: '', args: []);
  }

  /// `Gender`
  String get gender {
    return Intl.message('Gender', name: 'gender', desc: '', args: []);
  }

  /// `Age`
  String get age {
    return Intl.message('Age', name: 'age', desc: '', args: []);
  }

  /// `Create Complaint`
  String get createComplaint {
    return Intl.message(
      'Create Complaint',
      name: 'createComplaint',
      desc: '',
      args: [],
    );
  }

  /// `Submit Your Complaint`
  String get submitYourComplaint {
    return Intl.message(
      'Submit Your Complaint',
      name: 'submitYourComplaint',
      desc: '',
      args: [],
    );
  }

  /// `We'll review your complaint and get back to you soon`
  String get weWillReviewYourComplaintPrompt {
    return Intl.message(
      'We\'ll review your complaint and get back to you soon',
      name: 'weWillReviewYourComplaintPrompt',
      desc: '',
      args: [],
    );
  }

  /// `Subject`
  String get subjectFieldLabel {
    return Intl.message(
      'Subject',
      name: 'subjectFieldLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter complaint subject`
  String get subjectFieldHint {
    return Intl.message(
      'Enter complaint subject',
      name: 'subjectFieldHint',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get descriptionFieldLabel {
    return Intl.message(
      'Description',
      name: 'descriptionFieldLabel',
      desc: '',
      args: [],
    );
  }

  /// `Describe your complaint in detail`
  String get descriptionFieldHint {
    return Intl.message(
      'Describe your complaint in detail',
      name: 'descriptionFieldHint',
      desc: '',
      args: [],
    );
  }

  /// `Submit Complaint`
  String get submitButtonLabel {
    return Intl.message(
      'Submit Complaint',
      name: 'submitButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a subject`
  String get subjectValidationError {
    return Intl.message(
      'Please enter a subject',
      name: 'subjectValidationError',
      desc: '',
      args: [],
    );
  }

  /// `Please describe your complaint`
  String get descriptionValidationEmptyError {
    return Intl.message(
      'Please describe your complaint',
      name: 'descriptionValidationEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `Description should be at least 10 characters`
  String get descriptionValidationLengthError {
    return Intl.message(
      'Description should be at least 10 characters',
      name: 'descriptionValidationLengthError',
      desc: '',
      args: [],
    );
  }

  /// `Your complaint has been submitted successfully`
  String get complaintSubmittedSuccessfully {
    return Intl.message(
      'Your complaint has been submitted successfully',
      name: 'complaintSubmittedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Request Services`
  String get requestServices {
    return Intl.message(
      'Request Services',
      name: 'requestServices',
      desc: '',
      args: [],
    );
  }

  /// `Services`
  String get services {
    return Intl.message('Services', name: 'services', desc: '', args: []);
  }

  /// `No services available`
  String get noServices {
    return Intl.message(
      'No services available',
      name: 'noServices',
      desc: '',
      args: [],
    );
  }

  /// `View Details`
  String get viewDetails {
    return Intl.message(
      'View Details',
      name: 'viewDetails',
      desc: '',
      args: [],
    );
  }

  /// `Service ID:`
  String get serviceID {
    return Intl.message('Service ID:', name: 'serviceID', desc: '', args: []);
  }

  /// `Unknown Service`
  String get unknownService {
    return Intl.message(
      'Unknown Service',
      name: 'unknownService',
      desc: '',
      args: [],
    );
  }

  /// `No Ongoing Requuests`
  String get noOnngoingRequests {
    return Intl.message(
      'No Ongoing Requuests',
      name: 'noOnngoingRequests',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
