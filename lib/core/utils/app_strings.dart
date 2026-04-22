/// Central translation table for the app.
/// Usage:
///   final t = AppStrings.of(context);  // or AppStrings.isArabic(context)
///   Text(t.home)

import 'package:exhibition_book/core/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppStrings {
  final bool _ar;
  const AppStrings._(this._ar);

  // ─── Factory ─────────────────────────────────────────────────────────────
  static AppStrings of(BuildContext context) {
    final isArabic = context.watch<LocaleCubit>().state.isArabic;
    return AppStrings._(isArabic);
  }

  static AppStrings read(BuildContext context) {
    final isArabic = context.read<LocaleCubit>().state.isArabic;
    return AppStrings._(isArabic);
  }

  String _t(String en, String ar) => _ar ? ar : en;

  // ─── Auth ──────────────────────────────────────────────────────────────────
  String get welcomeBack => _t('Welcome Back 👋', 'مرحباً بعودتك 👋');
  String get loginSubtitle =>
      _t('Sign to your account', 'سجل الدخول إلى حسابك');
  String get email => _t('Email', 'البريد الإلكتروني');
  String get emailHint => _t('Your email', 'بريدك الإلكتروني');
  String get emailErrorEmpty =>
      _t('Please enter your email', 'الرجاء إدخال بريدك الإلكتروني');
  String get emailErrorValid =>
      _t('Please enter a valid email', 'الرجاء إدخال بريد إلكتروني صحيح');
  String get password => _t('Password', 'كلمة المرور');
  String get passwordHint => _t('Your password', 'كلمة المرور الخاصة بك');
  String get passErrorEmpty =>
      _t('Please enter your password', 'الرجاء إدخال كلمة المرور');
  String get passErrorLength => _t(
    'Password must be at least 6 characters',
    'يجب ألا تقل كلمة المرور عن 6 أحرف',
  );
  String get forgotPassword => _t('Forgot Password?', 'هل نسيت كلمة المرور؟');
  String get login => _t('Login', 'تسجيل الدخول');
  String get dontHaveAccount => _t('Don’t have an account?', 'ليس لديك حساب؟');
  String get signUp => _t('Sign Up', 'إنشاء حساب');
  String get orWith => _t('Or with', 'أو باستخدام');
  String get googleSignIn =>
      _t('Sign in with Google', 'تسجيل الدخول باستخدام جوجل');
  String get name => _t('Name', 'الاسم');
  String get nameHint => _t('Your name', 'اسمك بالكامل');
  String get nameErrorEmpty =>
      _t('Please enter your name', 'الرجاء إدخال اسمك');
  String get signUpSubtitle => _t(
    'Create account and discover new books',
    'قم بإنشاء حساب واستكشف كتباً جديدة',
  );
  String get register => _t('Register', 'تسجيل');
  String get haveAccount => _t('Have an account?', 'لديك حساب بالفعل؟');
  String get signIn => _t('Sign In', 'تسجيل الدخول');
  String get termsPrefix => _t(
    'By clicking Register, you agree to our ',
    'بالنقر على تسجيل، فإنك توافق على ',
  );
  String get termsSuffix =>
      _t('Terms, Data Policy.', 'الشروط وسياسة البيانات.');

  // ─── Bottom Nav ───────────────────────────────────────────────────────────
  String get navHome => _t('Home', 'الرئيسية');
  String get navCategory => _t('Category', 'التصنيفات');
  String get navCart => _t('Cart', 'السلة');
  String get navProfile => _t('Profile', 'الملف');

  // ─── Common ────────────────────────────────────────────────────────────────
  String get appName => _t('Bookly', 'بوكلي');
  String get cancel => _t('Cancel', 'إلغاء');
  String get logout => _t('Logout', 'تسجيل الخروج');
  String get logoutConfirm => _t(
    'Are you sure you want to logout?',
    'هل أنت متأكد أنك تريد تسجيل الخروج؟',
  );
  String get language => _t('Language', 'اللغة');
  String get seeAll => _t('See All', 'عرض الكل');
  String get orderNow => _t('Order Now', 'اطلب الآن');
  String get searchHint => _t('Search...', 'بحث...');

  // ─── Profile ───────────────────────────────────────────────────────────────
  String get profile => _t('Profile', 'الملف الشخصي');
  String get myAccount => _t('My Account', 'حسابي');
  String get offersPromos => _t('Offers & Promos', 'العروض والخصومات');
  String get yourFavorites => _t('Your Favorites', 'المفضلة');
  String get orderHistory => _t('Order History', 'سجل الطلبات');
  String get helpCenter => _t('Help Center', 'مركز المساعدة');
  String get supportChat => _t('Support Chat', 'محادثة الدعم');
  String get switchLanguage => _ar ? 'English' : 'العربية';
  String get darkMode => _t('Dark Mode', 'الوضع الداكن');

  // ─── Home ──────────────────────────────────────────────────────────────────
  String get topOfWeek => _t('Top of Week', 'أفضل الأسبوع');
  String get bestVendors => _t('Best Vendors', 'أفضل الموردين');
  String get authors => _t('Authors', 'المؤلفون');
  String get noBooksFound => _t('No books found', 'لا توجد كتب');

  // ─── Offers ────────────────────────────────────────────────────────────────
  String coupons(int count) =>
      _t('You Have $count Coupons to use', 'لديك $count كوبون للاستخدام');
  String get noOffers => _t('No Offers Available', 'لا توجد عروض متاحة');
  String get copy => _t('Copy', 'نسخ');

  // ─── Admin ─────────────────────────────────────────────────────────────────
  String get adminDashboard => _t('Admin Dashboard', 'لوحة التحكم');
  String get adminWelcome => _t('Welcome', 'مرحباً');
  String get adminSubtitle =>
      _t('Manage the app easily from here', 'أدر التطبيق بسهولة من هنا');
  String get mainSections => _t('Main Sections', 'الأقسام الرئيسية');
  String get quickActions => _t('Quick Actions', 'إجراءات سريعة');
  String get signOut => _t('Sign Out', 'تسجيل الخروج');

  String get books => _t('Books', 'الكتب');
  String get manageBooks => _t('Manage Books', 'إدارة الكتب');
  String get authorsLabel => _t('Authors', 'المؤلفون');
  String get manageAuth => _t('Manage Authors', 'إدارة المؤلفين');
  String get vendors => _t('Vendors', 'الموردون');
  String get manageVend => _t('Manage Vendors', 'إدارة الموردين');
  String get users => _t('Users', 'المستخدمون');
  String get manageUsers => _t('Manage Accounts', 'إدارة الحسابات');
  String get orders => _t('Orders', 'الطلبات');
  String get manageOrders => _t('Manage Orders', 'إدارة الطلبات');
  String get promotions => _t('Promotions', 'العروض');
  String get managePromos => _t('Manage Promos', 'إدارة العروض');
  String get chats => _t('Chats', 'المحادثات');
  String get supportChats => _t('Support Chats', 'محادثات الدعم');
  String get addBook => _t('Add Book', 'إضافة كتاب');
  String get addAuthor => _t('Add Author', 'إضافة مؤلف');
  String get addVendor => _t('Add Vendor', 'إضافة مورد');
  String get addPromo => _t('Add Promo', 'إضافة عرض');

  // ─── Cart / Checkout ───────────────────────────────────────────────────────
  String get cart => _t('Cart', 'سلة التسوق');
  String get emptyCart => _t('Your cart is empty', 'سلتك فارغة');
  String get checkout => _t('Checkout', 'إتمام الشراء');
  String get total => _t('Total', 'المجموع');

  // ─── Order History ─────────────────────────────────────────────────────────
  String get noOrders => _t('No orders yet', 'لا توجد طلبات بعد');
  String get orderStatus => _t('Status', 'الحالة');
  String get orderDate => _t('Date', 'التاريخ');
  String get youHaveNoOrders =>
      _t('You have no orders yet.', 'لا توجد طلبات حتى الآن.');
  String get retry => _t('Retry', 'إعادة المحاولة');
  String orderItems(int n) => _t('$n items', '$n عناصر');

  // ─── Status badges ────────────────────────────────────────────────────────
  String get statusPending => _t('Pending', 'قيد الانتظار');
  String get statusConfirmed => _t('Confirmed', 'تم التأكيد');
  String get statusShipped => _t('Shipped', 'تم الشحن');
  String get statusDelivered => _t('Delivered', 'تم التوصيل');
  String get statusCancelled => _t('Cancelled', 'ملغى');
  String statusLabel(String s) {
    switch (s.toLowerCase()) {
      case 'pending':
        return statusPending;
      case 'confirmed':
        return statusConfirmed;
      case 'shipped':
        return statusShipped;
      case 'delivered':
        return statusDelivered;
      case 'cancelled':
        return statusCancelled;
      default:
        return s.toUpperCase();
    }
  }

  // ─── Order Details ─────────────────────────────────────────────────────────
  String get orderDetails => _t('Order Details', 'تفاصيل الطلب');
  String get orderNo => _t('Order #', 'طلب #');
  String get dateLabel => _t('Date:', 'التاريخ:');
  String get notSpecified => _t('Not specified', 'غير محدد');
  String get notProvided => _t('Not provided', 'غير متوفر');
  String get shippingDetails => _t('Shipping Details', 'تفاصيل الشحن');
  String get nameLabel => _t('Name', 'الاسم');
  String get phoneLabel => _t('Phone', 'الهاتف');
  String get addressLabel => _t('Address', 'العنوان');
  String get orderItemsLabel => _t('Order Items', 'عناصر الطلب');
  String get qtyLabel => _t('Qty:', 'الكمية:');
  String get paymentSummary => _t('Payment Summary', 'ملخص الدفع');
  String get subtotal => _t('Subtotal', 'المجموع الفرعي');
  String get shipping => _t('Shipping', 'الشحن');
  String get tax => _t('Tax', 'الضريبة');
  String get discount => _t('Discount', 'الخصم');
  String get totalPayment      => _t('Total Payment',        'إجمالي الدفع');

  // ─── Checkout / Confirm Order ──────────────────────────────────────────────
  String get customerInfo      => _t('Customer Information', 'معلومات العميل');
  String get fullName          => _t('Full Name',            'الاسم الكامل');
  String get nameExample       => _t('Example: John Doe',    'مثال: محمد أحمد');
  String get nameRequired      => _t('Please enter your name', 'من فضلك أدخل اسمك');
  
  String get phoneNumber       => _t('Phone Number',         'رقم الهاتف');
  String get phoneExample      => _t('Example: 0501234567',  'مثال: 0501234567');
  String get phoneRequired     => _t('Please enter your phone number', 'من فضلك أدخل رقم هاتفك');
  String get phoneInvalid      => _t('Invalid phone number', 'رقم الهاتف غير صحيح');
  
  String get fullAddress       => _t('Full Address',         'العنوان الكامل');
  String get addressExample    => _t('City, Street, Building Number', 'المدينة، الشارع، رقم المبنى');
  String get addressRequired   => _t('Please enter your address', 'من فضلك أدخل عنوانك');
  
  String get orderSummary      => _t('Order Summary',        'ملخص الطلب');
  String get taxWithPercent    => _t('Tax (5%)',             'الضريبة (5%)');
  String get dateTimeLabel     => _t('Date & Time',          'التاريخ والوقت');
  String get selectDateTime    => _t('Select Date and Time', 'اختر التاريخ والوقت');
  String get confirmOrderBtn   => _t('Confirm Order',        'تأكيد الطلب');
  
  String get orderSuccess      => _t('Order Confirmed Successfully', 'تم تأكيد الطلب بنجاح');
  String get orderSuccessSub   => _t('Customer service will contact you shortly.', 'وسيتم التواصل مع حضرتك من خلال خدمة العملاء.');
  String get returnToHome      => _t('Return to Home',       'العودة للرئيسية');
}
