class DataString {
//==============================================================================
// order view
// -----state
  static const String stateAccept = "بإنتظار الموافقة";
  static const String stateRepair = "جاري التحضير";
  static const String stateDelivery = "في الطريق";
// login view

  static const String welcomeLoginTittle = "مرحبا بك مرة أخرى";
  static const String welcomeSubLoginTittle = 'يمكنك تسجيل الدخول الأن';
  static const String welcomeSubRegisterTittle = 'يمكنك تسجيل حساب جديد الأن';
  static const String phone = "رقم الجوال";
  static const String phoneError = "رقم الجوال غير صحيح";
  static const String password = "كلمة المرور";

  static const String forgetPassword = "نسيت كلمة المرور؟";

  static const String notHaveAccount = "ليس لديك حساب؟";
static const String haveAccount = "لديك حساب بالفعل؟";
  static const String register = 'تسجيل الأن';

  static const String login = 'تسجيل الدخول';

  static const String passwordError = 'كلمة المرور غير صحيحة';



  static String empty(String text) => "$text فارغ ";
  static const String codeKSA = "+966";
  static const String codeEGY = "+20";
  static const String activateAccount = 'برجاء تفعيل الحساب';
  //--------------------------------------------------------------------------------
// register view
  static const String country = "اختر مدينتك";
  static const String name = "اسم المستخدم";
  static const String city = "المدينة";
  static const String rePasswordError='كلمة المرور غير متطابقة';
//--------------------------------------------------------------------------------
//confirm account
static const String confirmAccountTittle= "تفعيل الحساب";
static const String forgetTittle= "نسيت كلمة المرور";
static const  String confirmAccountSubTittle= "أدخل الكود المكون من 4 أرقام المرسل علي رقم الجوال";
static const String changePhone= "تغيير رقم الجوال";
static const String confirmButton= "تأكيد الكود";
static const String resendCode= "لم تستلم الكود ؟\nيمكنك إعادة إرسال الكود بعد";
static const String resendCodeButton= "إعادة الإرسال";
static const String verifyCodeError= "الكود غير صحيح";
//--------------------------------------------------------------------------------
//forget password
static const String forgetPasswordTittle= "نسيت كلمة المرور";
static const String forgetPasswordSubTittle= "أدخل رقم الجوال المرتبط بحسابك";
//--------------------------------------------------------------------------------
//reset password
static const String resetPasswordSubTittle="أدخل كلمة المرور الجديدة";
static const String resetPasswordButton="تغيير كلمة المرور";
//--------------------------------------------------------------------------------
//home view
  static const String  home='الرئيسية';
  static const String  order='الطلبات';
  static const String  myAccount='حسابي';
  static const String  favorite='المفضلة';
static const String  notification='الإشعارات';
//--------------------------------------------------------------------------------
//main page
static const String  mainPage='الرئيسية';
static const String  search='ابحث عن ماتريد؟';
static const String  cart='سلة ثمار';
static const String  sections='الأقسام';
static const String items  ='الأصناف';
static const String delivery ='التوصيل إلى';
static const String viewAll ='عرض الكل';
static const String amount ='السعر / ';
static const String add ='أضف للسلة';
//--------------------------------------------------------------------------------
//product view
static const String  codeProduct='كود المنتج';
static const String  description='تفاصيل المنتج';
static const String  review='التقييمات';
static const String  relatedProducts='منتجات مشابهة';
static const String  showAll='عرض الكل';
static const String  addToCard='إضافة إلي السلة';
static const String  noReview='لا يوجد تقييمات';
//--------------------------------------------------------------------------------
//favorite view
static const String  myFav='المفضلة';
//--------------------------------------------------------------------------------
//cart view
static const String  myCart='السلة';

}
