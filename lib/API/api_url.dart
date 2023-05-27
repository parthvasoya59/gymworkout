class Api {
  static const baseUrl = 'http://68.183.86.2/package_delivery/api/v1/';


  static const loginUrl = '${baseUrl}login';
  static const registerUrl = '${baseUrl}register';
  static const verifyUserUrl = '${baseUrl}verfiy-user';
  static const restPasswordUrl = '${baseUrl}forgot-password-link';
  static const driverVerificationUrl = '${baseUrl}driver-verification';
  static const notificationListUrl = '${baseUrl}notification-list';
  static const showRecentShipmentUrl = '${baseUrl}show-recent-shipment';
  static const showShipmentListUrl = '${baseUrl}list-shipment';
  static const driverListUrl = '${baseUrl}driver-list';
  static const companyListUrl = '${baseUrl}company-list';
  static const topSuggestionDriverListUrl = '${baseUrl}topsuggestion-driver-list';
  static const familiarFacesListUrl = '${baseUrl}familiar-driver-list';
  static const createShipmentUrl = '${baseUrl}create-shipment';
  static const shipmentImageUrl = '${baseUrl}shipment-image';
  static const editProfileUrl = '${baseUrl}edit-profile';
  static const getProfileUrl = '${baseUrl}get-profile';
  static const shipmentSummaryUrl = '${baseUrl}view-shipment';
  static const followersListCompanyUrl = '${baseUrl}followers-list-company';
  static const followUnfollowCompanyUrl = '${baseUrl}follow-unfollow-company';
  static const storePaymentDetailUrl = '${baseUrl}store-payment-detail';
  static const followedCompanyListUrl = '${baseUrl}followed-company-list';
  static const addRatingUrl = '${baseUrl}add-driver-rating-comment';
  static const packageSizeListListUrl= '${baseUrl}package-size-list';
  static const shipmentDeliveredCompanyDriver= '${baseUrl}shipment-delivered-company-driver';
  static const shipmentStatusChange= '${baseUrl}change-shipment-status';
  static const shipmentDeliveryImageUpload= '${baseUrl}delivered-shipment-image';
  static const seeCustomerRatingReviewUrl = '${baseUrl}see-customer-rating-review';
  static const updateFreeDeliveryUrl = '${baseUrl}update-free-delivery';
  static const getFreeDeliveryUrl = '${baseUrl}get-free-delivery';
  static const requestWithdrawalUrl = '${baseUrl}request-withdrawal';
  static const couponListUrl = '${baseUrl}coupon-list';
  static const applyCouponUrl = '${baseUrl}apply-coupon';
  static const applyCouponHistoryUrl = '${baseUrl}coupon-history';


  ///PAYSTACK URL///
  static const initTransactionUrl = 'https://api.paystack.co/transaction/initialize';



}
