

import 'package:easy_localization/easy_localization.dart';

// class DataString {
//
// static String translate(String text){
//   return text.tr();
// }
// // ==============================================================================
// // order view
// // -----state
//   static  String stateAccept =translate("stateAccept");
//   static  String stateRepair = translate("stateRepair");
//   static  String stateDelivery = translate("stateDelivery");
// // login view
//
//   // login view
//   static String welcomeLoginTittle = translate('welcomeLoginTittle');
//   static String welcomeSubLoginTittle = translate('welcomeSubLoginTittle');
//   static String welcomeSubRegisterTittle = translate('welcomeSubRegisterTittle');
//   static String phone = translate('phone');
//   static String phoneError = translate('phoneError');
//   static String password = translate('password');
//   static String forgetPassword = translate('forgetPassword');
//   static String notHaveAccount = translate('notHaveAccount');
//   static String haveAccount = translate('haveAccount');
//   static String register = translate('register');
//   static String login = translate('login');
//   static String passwordError = translate('passwordError');
//   static String empty (text) => "$text ${translate('empty')}";
//   static String codeKSA = translate('codeKSA');
//   static String codeEGY = translate('codeEGY');
//   static String activateAccount = translate('activateAccount');
//   static String country = translate('country');
//   static String name = translate('name');
//   static String city = translate('city');
//   static String rePasswordError = translate('rePasswordError');
//
//   // Continue with other variables
//   static String confirmAccountTittle = translate('confirmAccountTittle');
//   static String forgetTittle = translate('forgetTittle');
//   static String confirmAccountSubTittle = translate('confirmAccountSubTittle');
//   static String changePhone = translate('changePhone');
//   static String confirmButton = translate('confirmButton');
//   static String resendCode = translate('resendCode');
//   static String resendCodeButton = translate('resendCodeButton');
//   static String verifyCodeError = translate('verifyCodeError');
//   static String forgetPasswordTittle = translate('forgetPasswordTittle');
//   static String forgetPasswordSubTittle = translate('forgetPasswordSubTittle');
//   static String resetPasswordSubTittle = translate('resetPasswordSubTittle');
//   static String resetPasswordButton = translate('resetPasswordButton');
//   static String home = translate('home');
//   static String order = translate('order');
//   static String myAccount = translate('myAccount');
//   static String favorite = translate('favorite');
//   static String notification = translate('notification');
//   static String mainPage = translate('mainPage');
//   static String search = translate('search');
//   static String cart = translate('cart');
//   static String sections = translate('sections');
//   static String items = translate('items');
//   static String delivery = translate('delivery');
//   static String viewAll = translate('viewAll');
//   static String amount = translate('amount');
//   static String add = translate('add');
//   static String codeProduct = translate('codeProduct');
//   static String description = translate('description');
//   static String review = translate('review');
//   static String relatedProducts = translate('relatedProducts');
//   static String showAll = translate('showAll');
//   static String addToCard = translate('addToCard');
//   static String noReview = translate('noReview');
//   static String addToCart = translate('addToCart');
//   static String myFav = translate('myFav');
//   static String myCart = translate('myCart');
//   static String vipMessage = translate('vipMessage');
//   static String total = translate('total');
//   static String totalPriceBeforeDiscount = translate('totalPriceBeforeDiscount');
//   static String totalDiscount = translate('totalDiscount');
//   static String vat = translate('vat');
//   static String totalCard = translate('totalCard');
//   static String finishedCard = translate('finishedCard');
//   static String haveCoupon = translate('haveCoupon');
//   static String enterCoupon = translate('enterCoupon');
//   static String apply = translate('apply');
//   static String currency = translate('currency');
// //----------------------------------------------------------------
//   //user settings
//   static String personalInfo = translate("personalInfo");
//   static String wallet = translate("wallet");
//   static String address = translate("address");
//   static String payment = translate("payment");
//   static String orders = translate("orders");
//   static String faq = translate("faq");
//   static String privacy = translate("privacy");
//   static String contactUs = translate("contactUs");
//   static String complaint = translate("complaint");
//   static String share = translate("share");
//   static String about = translate("about");
//   static String terms = translate("terms");
//   static String rate = translate("rate");
//   static String logout = translate("logout");
//   static String changeLanguage = "changeLanguage";
//   static String subject = translate("subject");
//   static String send = translate("send");
//   static String addAddress = translate("addAddress");
//   static String addressType = translate("addressType");
//   static String descriptionAddress = translate("descriptionAddress");
//   static String homeAddress = translate("homeAddress");
//   static String workAddress = translate("workAddress");
//   static String addCard = translate("addCard");
//   static String cardHolderName = translate("cardHolderName");
//   static String cardNumber = translate("cardNumber");
//   static String expiryDate = translate("expiryDate");
//   static String cvv = translate("cvv");
//   static String productAdded = translate("productAdded");
//   static String browseOffers = translate("browseOffers");
//   static String moveToCart = translate("moveToCart");
//   static String quantity = translate("quantity");
//   static String productComment = translate("productComment");
//   static String productRate = translate("productRate");
//   static String productCommentHint = translate("productCommentHint");
//   static String rateProduct = translate("rateProduct");
//   static String orderDone = translate("orderDone");
//   static String orderDoneSub = translate("orderDoneSub");
//   static String myOrders = translate("myOrders");
//   static String confirmSelection = translate("confirmSelection");
//   static String addPaymentCard = translate("addPaymentCard");
//   static String savedCards = translate("savedCards");
//   static String mobile = translate("mobile");
//   static String chooseDeliveryAddress = translate("chooseDeliveryAddress");
//   static String chooseDeliveryTime = translate("chooseDeliveryTime");
//   static String chooseDayAndDate = translate("chooseDayAndDate");
//   static String chooseTime = translate("chooseTime");
//   static String notesAndInstructions = translate("notesAndInstructions");
//   static String choosePaymentMethod = translate("choosePaymentMethod");
//   static String orderSummary = translate("orderSummary");
//   static String finishOrder = translate("finishOrder");
//   static String cancelOrder = translate("cancelOrder");
//   static String deliveryAddress = translate("deliveryAddress");
//   static String paymentMethod = translate("paymentMethod");
//   static String finished = translate("finished");
//   static String current = translate("current");
//   static String filter = translate("filter");
//   static String price = translate("price");
//   static String sort = translate("sort");
//   static String fromHighToLow = translate("fromHighToLow");
//   static String fromLowToHigh = translate("fromLowToHigh");
//   static String applyFilter = translate("applyFilter");
//   static String orYouCanSendMessage = translate("orYouCanSendMessage");
//
//
//
//
// }


class DataString{
  static String empty(text) => "$text ${'empty'.tr()}";

  static const stateAccept = 'stateAccept';
  static const stateRepair = 'stateRepair';
  static const stateDelivery = 'stateDelivery';
  static const welcomeLoginTittle = 'welcomeLoginTittle';
  static const welcomeSubLoginTittle = 'welcomeSubLoginTittle';
  static const welcomeSubRegisterTittle = 'welcomeSubRegisterTittle';
  static const phone = 'phone';
  static const phoneError = 'phoneError';
  static const password = 'password';
  static const forgetPassword = 'forgetPassword';
  static const notHaveAccount = 'notHaveAccount';
  static const haveAccount = 'haveAccount';
  static const register = 'register';
  static const login = 'login';
  static const passwordError = 'passwordError';
  static const codeKSA = 'codeKSA';
  static const codeEGY = 'codeEGY';
  static const activateAccount = 'activateAccount';
  static const country = 'country';
  static const name = 'name';
  static const city = 'city';
  static const rePasswordError = 'rePasswordError';
  static const confirmAccountTittle = 'confirmAccountTittle';
  static const forgetTittle = 'forgetTittle';
  static const confirmAccountSubTittle = 'confirmAccountSubTittle';
  static const changePhone = 'changePhone';
  static const confirmButton = 'confirmButton';
  static const resendCode = 'resendCode';
  static const resendCodeButton = 'resendCodeButton';
  static const verifyCodeError = 'verifyCodeError';
  static const forgetPasswordTittle = 'forgetPasswordTittle';
  static const forgetPasswordSubTittle = 'forgetPasswordSubTittle';
  static const resetPasswordSubTittle = 'resetPasswordSubTittle';
  static const resetPasswordButton = 'resetPasswordButton';
  static const home = 'home';
  static const order = 'order';
  static const myAccount = 'myAccount';
  static const favorite = 'favorite';
  static const notification = 'notification';
  static const mainPage = 'mainPage';
  static const search = 'search';
  static const cart = 'cart';
  static const sections = 'sections';
  static const items = 'items';
  static const delivery = 'delivery';
  static const viewAll = 'viewAll';
  static const amount = 'amount';
  static const add = 'add';
  static const codeProduct = 'codeProduct';
  static const description = 'description';
  static const review = 'review';
  static const relatedProducts = 'relatedProducts';
  static const showAll = 'showAll';
  static const addToCard = 'addToCard';
  static const noReview = 'noReview';
  static const addToCart = 'addToCart';
  static const myFav = 'myFav';
  static const myCart = 'myCart';
  static const vipMessage = 'vipMessage';
  static const total = 'total';
  static const totalPriceBeforeDiscount = 'totalPriceBeforeDiscount';
  static const totalDiscount = 'totalDiscount';
  static const vat = 'vat';
  static const totalCard = 'totalCard';
  static const finishedCard = 'finishedCard';
  static const haveCoupon = 'haveCoupon';
  static const enterCoupon = 'enterCoupon';
  static const apply = 'apply';
  static const currency = 'currency';
  static const personalInfo = 'personalInfo';
  static const wallet = 'wallet';
  static const address = 'address';
  static const payment = 'payment';
  static const orders = 'orders';
  static const faq = 'faq';
  static const privacy = 'privacy';
  static const contactUs = 'contactUs';
  static const complaint = 'complaint';
  static const share = 'share';
  static const about = 'about';
  static const terms = 'terms';
  static const rate = 'rate';
  static const logout = 'logout';
  static const changeLanguage = 'changeLanguage';
  static const subject = 'subject';
  static const send = 'send';
  static const addAddress = 'addAddress';
  static const addressType = 'addressType';
  static const descriptionAddress = 'descriptionAddress';
  static const homeAddress = 'homeAddress';
  static const workAddress = 'workAddress';
  static const addCard = 'addCard';
  static const cardHolderName = 'cardHolderName';
  static const cardNumber = 'cardNumber';
  static const expiryDate = 'expiryDate';
  static const cvv = 'cvv';
  static const productAdded = 'productAdded';
  static const browseOffers = 'browseOffers';
  static const moveToCart = 'moveToCart';
  static const quantity = 'quantity';
  static const productComment = 'productComment';
  static const productRate = 'productRate';
  static const productCommentHint = 'productCommentHint';
  static const rateProduct = 'rateProduct';
  static const orderDone = 'orderDone';
  static const orderDoneSub = 'orderDoneSub';
  static const myOrders = 'myOrders';
  static const confirmSelection = 'confirmSelection';
  static const addPaymentCard = 'addPaymentCard';
  static const savedCards = 'savedCards';
  static const mobile = 'mobile';
  static const chooseDeliveryAddress = 'chooseDeliveryAddress';
  static const chooseDeliveryTime = 'chooseDeliveryTime';
  static const chooseDayAndDate = 'chooseDayAndDate';
  static const chooseTime = 'chooseTime';
  static const notesAndInstructions = 'notesAndInstructions';
  static const choosePaymentMethod = 'choosePaymentMethod';
  static const orderSummary = 'orderSummary';
  static const finishOrder = 'finishOrder';
  static const cancelOrder = 'cancelOrder';
  static const deliveryAddress = 'deliveryAddress';
  static const paymentMethod = 'paymentMethod';
  static const finished = 'finished';
  static const current = 'current';
  static const filter = 'filter';
  static const price = 'price';
  static const sort = 'sort';
  static const fromHighToLow = 'fromHighToLow';
  static const fromLowToHigh = 'fromLowToHigh';
  static const applyFilter = 'applyFilter';
  static const orYouCanSendMessage = 'orYouCanSendMessage';



}