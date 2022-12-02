// Created by Vishwa on 14/11/22.
// Project Name diamond_bag_tracking.

/*
Offline saved data String names
 */
String kToken = 'Token';
String kMobileNumber = 'MobileNumber';

String kDeviceID = 'DeviceID';
String kUserCode = 'UserCode';
String kFirebaseToken = 'FirebaseToken';

/*
REST Api error text declaration
 */

String kConnectTimeOutError = 'Error is coming while connecting to server.';
String kReceiveTimeoutError =
    'server is taking too much to send data back to device.';
String kSendTimeoutError = 'send Timeout exception is coming.';
String kServiceUnavailableError = 'send Timeout exception is coming.';

/*
Rest Api
 */
// http://www.mindtechsolutions.com/tester/MindcubeDiamondAPI_Test/api/BagTracking/GetBagsDashbordDetails
String kBaseUrl = 'http://www.mindtechsolutions.com/tester/MindcubeDiamondAPI';
String kAuthenticateUser = '/api/Authentication/MobileAuthentication';
String kValidateOTP = '/api/Authentication/CheckValidateOTP';
String kBagsDashbordDetails = '/api/BagTracking/GetBagsDashbordDetails';
String kTargetsBags = '/api/BagTracking/GetTargetsBagsList';
String kBagsStatus = '/api/BagTracking/GetBagsStatus';
String kBagDetails = '/api/BagTracking/GetBagDetails';
String kBagStatisticsData = '/api/BagTracking/GetBagStatistics';
String kFlutingBagsList = '/api/BagTracking/GetFlutingBagsList';
String kBagsListCustomerCodeWise =
    '/api/BagTracking/GetBagsListCustomerCodeWise';
String kBagsListbyCustomerCode = '/api/BagTracking/GetBagsListbyCustomerCode';

/*
Custom Route Declaration
 */

const loginScreen = '/';
const dashBoardScreen = '/Dashboard';
const homeScreen = '/Home';
const settingsScreen = '/Settings';
const userProfileScreen = '/UserProfile';
const targetsScreen = '/Targets';
const bagStatusStepperScreen = '/BagStatusStepper';
const bagStatusTableScreen = '/BagStatusTable';
const bagStatisticsStepperScreen = '/BagStatisticsStepper';
const bagStatisticsFlutingScreen = '/BagStatisticsFluting';
const bagBagListCustomCodeWiseScreen = '/BagListCustomCodeWise';
const bagBagListCustomCodeScreen = '/BagListCustomCode';

/*
assets font name Declaration
 */
const String fontOpenSans = 'Open Sans';

/*
assets icon name Declaration
 */

String iconDiamondLogo = 'assets/images/diamondlogo.png';
String iconBox = 'assets/images/boxicon.svg';
String iconAssortment = 'assets/images/assortmenticon.svg';
String iconBottomHome = 'assets/images/bottomhome.svg';
String iconBottomProfile = 'assets/images/bottomprofile.svg';
String iconBottomSetting = 'assets/images/bottomsetting.svg';
String iconDispatch = 'assets/images/dispatchicon.svg';
String iconFluting = 'assets/images/flutingicon.svg';
String iconPacking = 'assets/images/packingicon.svg';
String iconSelected = 'assets/images/selectedicon.svg';
String iconShoppingCart = 'assets/images/shoppingcarticon.svg';
String iconStatus = 'assets/images/statusicon.svg';
String iconMenu = 'assets/images/menu.png';
String iconStatusIcon = 'assets/images/status.png';

/*
String Constant Declaration
 */

String kContinue = 'Continue';
String kAppName = 'Diamond Bag Tracking';
String kMessage = 'message';
String kGetOTp = 'Get OTP';
String kVerify = 'Verify';
String kOtp = 'OTP';
String kBagEnquiry = 'Bag Enquiry';
String kBagNo = 'Bag Number';
String kTargets = 'Targets';
String kBagStatus = 'Bag Status';
String kBagStatistics = 'Bag Statistics';
String kBagFluting = "Bag's in Fluting";
String kEnterMobileNo = '* Enter Mobile Number';
String kEnterOTP = '* Enter OTP';
String kEnterSomething = 'Enter Something';
String kCustomerCode = 'Customer Code';
