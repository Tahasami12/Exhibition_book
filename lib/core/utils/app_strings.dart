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
  String get welcomeBack => _t('Welcome Back 👋', '👋 مرحبا بعودتك');
  String get loginSubtitle =>
      _t('Sign to your account', 'تسجيل الدخول الى حسابك');
  String get email => _t('Email', 'الايميل');
  String get emailHint => _t('Your email', 'الايميل الخاص بك');
  String get emailErrorEmpty =>
      _t('Please enter your email', 'لا يمكن ان يكون الحقل فارغا');
  String get emailErrorValid =>
      _t('Please enter a valid email', 'يجب ان يحتوي الايميل على علامة @');
  String get password => _t('Password', 'كلمة المرور');
  String get passwordHint => _t('Your password', 'كلمة المرور الخاصة بك');
  String get passErrorEmpty =>
      _t('Please enter your password', 'لا يمكن ان يكون الحقل فارغا');
  String get passErrorLength => _t(
    'Password must be at least 6 characters',
    'يجب ألا تقل كلمة المرور عن 6 أحرف',
  );
  String get forgotPassword => _t('Forgot Password?', 'نسيت كلمة المرور');
  String get login => _t('Login', 'تسجيل الدخول');
  String get dontHaveAccount => _t('Don’t have an account?', ' ليس لديك حساب ؟');
  String get signUp => _t('Sign Up', 'انشئ حساب');
  String get orWith => _t('Or with', 'او باستخدام');
  String get googleSignIn =>
      _t('Sign in with Google', 'سجل باستخدام جوجل');
  String get name => _t('Name', 'الاسم');
  String get nameHint => _t('Your name', 'اسمك');
  String get nameErrorEmpty =>
      _t('Please enter your name', 'لا يمكن ان يكون الحقل فارغا');
  String get signUpSubtitle => _t(
    'Create account and discover new books',
    'انشئ حسابا و اختر قائمتك المفضلة',
  );
  String get register => _t('Register', 'تسجيل');
  String get haveAccount => _t('Have an account?', 'تمتلك حسابا ؟');
  String get signIn => _t('Sign In', 'تسجيل الحساب');
  String get termsPrefix => _t(
    'By clicking Register, you agree to our ',
    ' بالضغط على زر التسجيل انت توافق على  ',
  );
  String get termsSuffix =>
      _t('Terms, Data Policy.', 'الشروط وسياسة البيانات');

  // ─── Bottom Nav ───────────────────────────────────────────────────────────
  String get navHome => _t('Home', 'الرئيسية');
  String get navCategory => _t('Category', 'التصنيفات');
  String get navCart => _t('Cart', 'السلة');
  String get navProfile => _t('Profile', 'الملف الشخصي');

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
  String get offersPromos => _t('Offers & Promos', 'العروض والتخفيضات');
  String get yourFavorites => _t('Your Favorites', 'المفضلة لديك');
  String get orderHistory => _t('Order History', 'سجل الطلبات');
  String get helpCenter => _t('Help Center', 'مركز المساعدة');
  String get supportChat => _t('Support Chat', 'محادثة الدعم');
  String get switchLanguage => _ar ? 'English' : 'العربية';
  String get darkMode => _t('Dark Mode', 'الوضع الداكن');

  // ─── Home ──────────────────────────────────────────────────────────────────
  String get topOfWeek => _t('Top of Week', 'الأفضل هذا الأسبوع');
  String get bestVendors => _t('Best Vendors', 'أفضل البائعين');
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
  String get vendors => _t('Vendors', 'البائعين');
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
  String get phoneLabel => _t('Phone', 'رقم الهاتف');
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
  String get nameRequired      => _t('Please enter your name', 'لا يمكن ان يكون الحقل فارغا');
  
  String get phoneNumber       => _t('Phone Number',         'رقم الهاتف');
  String get phoneExample      => _t('Example: 0501234567',  'مثال: 0501234567');
  String get phoneRequired     => _t('Please enter your phone number', 'يرجى إدخال رقم هاتفك، حتى نتمكن من توصيل طلبك بسهولة أكبر');
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

  // ─── Onboarding ────────────────────────────────────────────────────────────
  String get skip => _t('Skip', 'تخطي');
  String get continueBtn => _t('Continue', 'استمرار');
  String get getStarted => _t('Get Started', 'ابدأ الان');
  
  String get onBoardingTitle1 => _t('Now reading books\nwill be easier', 'قراءة الكتب أصبحت أسهل الآن');
  String get onBoardingTitle2 => _t('Your Bookish Soulmate\nAwaits', 'رفيقك في القراءة ينتظرك');
  String get onBoardingTitle3 => _t('Start Your Adventure', 'ابدأ مغامرتك');

  String get onBoardingDesc1 => _t(
    'Discover new worlds, join a vibrant reading community. Start your reading adventure effortlessly with us.',
    'اكتشف عوالم جديدة، انضم إلى مجتمع قراءة نابض بالحياة. ابدأ مغامرة القراءة الخاصة بك بسهولة معنا.'
  );
  String get onBoardingDesc2 => _t(
    'Let us be your guide to the perfect read. Discover books tailored to your tastes for a truly rewarding experience.',
    'دعنا نكون دليلك إلى القراءة المثالية. اكتشف كتبًا مصممة خصيصًا لأذواقك لتجربة مجزية حقًا.'
  );
  String get onBoardingDesc3 => _t(
    'Ready to embark on a quest for inspiration and knowledge? Your adventure begins now. Let\'s go!',
    'هل أنت مستعد للانطلاق في رحلة بحث عن الإلهام والمعرفة؟ مغامرتك تبدأ الآن. هيا بنا!'
  );

  // ─── My Account ────────────────────────────────────────────────────────────
  String get myAccountTitle => _t('My Account', 'حسابي');
  String get changePicture => _t('Change Picture', 'تغيير الصورة');
  String get saveChanges => _t('Save Changes', 'حفظ التغييرات');
  String get profileUpdated => _t('Profile updated successfully!', 'تم تحديث الملف الشخصي بنجاح!');
  String get profileUpdateError => _t('Error updating profile', 'خطأ في تحديث الملف الشخصي');

  // ─── Help Center ───────────────────────────────────────────────────────────
  String get helpCenterSubtitle => _t('Tell us how we can help 👋', 'أخبرنا كيف يمكننا مساعدتك 👋');
  String get helpCenterDesc => _t(
    'Chapters are standing by for services & support!',
    'فريق Chapter جاهز لخدمتك ودعمك!'
  );
  String get sendEmail => _t('Send to your email', 'أرسل إلى بريدك الإلكتروني');
  String get sendPhone => _t('Send to your phone', 'أرسل لهاتفك');

  // ─── Profile ───────────────────────────────────────────────────────────────
  String get userNamePlaceholder => _t('User Name', 'اسم المستخدم');
  String get emailPlaceholder => _t('email@example.com', 'email@example.com');
  
  // ─── Product Details ───────────────────────────────────────────────────────
  String get addToCart => _t('Add to Cart', 'أضف إلى السلة');

  // ─── Extra ─────────────────────────────────────────────────────────────────
  String get orderReceived => _t('You Received The Order!', 'لقد استلمت الطلب!');
  String get orderNumberLabel => _t('Order #', 'طلب رقم ');
  String get tellUsFeedback => _t('Tell us your feedback ✨', 'أخبرنا برأيك ✨');
  String get outOfFiveStars => _t('out of 5 stars', 'من 5 نجوم');
  String get feedbackHint => _t('Write something for us!', 'اكتب شيئاً لنا!');
  String get doneBtn => _t('Done', 'تم');
  String get locationTitle => _t('Location', 'الموقع');
  String get fillAllFields => _t('Please fill in all fields', 'يرجى ملء جميع الحقول');
  String get governorate => _t('Governorate', 'المحافظة');
  String get city => _t('City', 'المدينة');
  String get confirmationBtn => _t('Confirmation', 'تأكيد');
  String get ourCollection => _t('Our Collection', 'مجموعتنا');
  String get ourVendors => _t('Our Vendors', 'بائعينا');
  String get checkAuthors => _t('Check the authors', 'تحقق من المؤلفين');
  String get loginToSeeOrders => _t('Please log in to see your orders.', 'يرجى تسجيل الدخول لمشاهدة طلباتك.');
  String get noOrderNotifications => _t('No order notifications yet.', 'لا توجد إشعارات طلبات بعد.');
  String get noPromotions => _t('No promotions available.', 'لا توجد عروض متاحة.');
  String get codeLabel => _t('Code:', 'كود:');
  String get offLabel => _t('OFF', 'خصم');
  String get typeToSearch => _t('Type to search for books', 'اكتب للبحث عن الكتب');
  String get noBooksFoundFor => _t('No books found for', 'لم يتم العثور على كتب لـ');
  String get supportTitle => _t('Support', 'الدعم');
  String get replyInstantly => _t('We usually reply instantly', 'نحن نرد عادةً فوراً');
  String get startConversation => _t('Start a conversation!\nWe\'re here to help.', 'ابدأ محادثة!\nنحن هنا للمساعدة.');
  String get typeMessageHint => _t('Type a message...', 'اكتب رسالة...');
  String get youHaveCoupons => _t('You Have', 'لديك');
  String get couponsToUse => _t('Coupons to use', 'كوبونات لاستخدامها');
  String get copyBtn => _t('Copy', 'نسخ');
  String get removedFromFav => _t('removed from favorites', 'تمت إزالته من المفضلة');
  String get addedToFav => _t('added to favorites', 'تمت إضافته إلى المفضلة');
  String get review => _t('Review', 'مراجعة');
  String get addedToCartMsg => _t('added!', 'تمت الإضافة!');
  String get bookDetails => _t('Book Details', 'تفاصيل الكتاب');
  String get continueShopping => _t('Continue Shopping', 'استمرار التسوق');
  String get notifications => _t('Notifications', 'الإشعارات');
  String get emptyCartDesc => _t(
    'Discover new worlds, join a vibrant reading community. Start your reading adventure effortlessly with us.',
    'اكتشف عوالم جديدة، انضم إلى مجتمع قراءة نابض بالحياة. ابدأ مغامرة القراءة الخاصة بك بسهولة معنا.'
  );
}
