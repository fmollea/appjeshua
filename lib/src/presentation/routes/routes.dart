import 'package:appjeshua/src/presentation/pages/billing_address_page.dart';
import 'package:appjeshua/src/presentation/pages/category_page.dart';
import 'package:appjeshua/src/presentation/pages/delivery_point_page.dart';
import 'package:appjeshua/src/presentation/pages/detail_order.dart';
import 'package:appjeshua/src/presentation/pages/detail_product.dart';
import 'package:appjeshua/src/presentation/pages/details_profile_page.dart';
import 'package:appjeshua/src/presentation/pages/edit_profile_page.dart';
import 'package:appjeshua/src/presentation/pages/favorite_page.dart';
import 'package:appjeshua/src/presentation/pages/forget_password_page.dart';
import 'package:appjeshua/src/presentation/pages/frequent_quetions_page.dart';
import 'package:appjeshua/src/presentation/pages/help_page.dart';
import 'package:appjeshua/src/presentation/pages/history_order_page.dart';
import 'package:appjeshua/src/presentation/pages/home_page.dart';
import 'package:appjeshua/src/presentation/pages/list_billing_address_page.dart';
import 'package:appjeshua/src/presentation/pages/list_delivery_address_page.dart';
import 'package:appjeshua/src/presentation/pages/login_page.dart';
import 'package:appjeshua/src/presentation/pages/main_page.dart';
import 'package:appjeshua/src/presentation/pages/notification_page.dart';
import 'package:appjeshua/src/presentation/pages/payment_method_page.dart';
import 'package:appjeshua/src/presentation/pages/pills_page.dart';
import 'package:appjeshua/src/presentation/pages/products_list.dart';
import 'package:appjeshua/src/presentation/pages/profile_page.dart';
import 'package:appjeshua/src/presentation/pages/purchase_confirmation_page.dart';
import 'package:appjeshua/src/presentation/pages/purchase_made_page.dart';
import 'package:appjeshua/src/presentation/pages/purchase_summary_page.dart';
import 'package:appjeshua/src/presentation/pages/contact_web_page.dart';
import 'package:appjeshua/src/presentation/pages/terms_privacy_page.dart';
import 'package:appjeshua/src/presentation/pages/info_page.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getApplicationRoutes() => <String, WidgetBuilder>{
      '/': (BuildContext context) => HomePage(),
      'login': (BuildContext context) => LoginPage(),
      'main_page': (BuildContext context) => MainPage(),
      'forget_pass_page': (BuildContext context) => ForgetPasswordPage(),
      'pills_page': (BuildContext context) => PillsPage(),
      'help_page': (BuildContext context) => HelpPage(),
      'products_page': (BuildContext context) => ProductsListPage(),
      'category_page': (BuildContext context) => CategoryPage(),
      'products_detail_page': (BuildContext context) => DetailProductPage(),
      'purchase_summary_page': (BuildContext context) => PurchaseSumaryPage(),
      'delivery_point_page': (BuildContext context) => DeliveryPointPage(),
      'history_order_page': (BuildContext context) => HistoryOrderPage(),
      'payment_method_page': (BuildContext context) => PaymentMethodPage(),
      'purchase_confirmation_page': (BuildContext context) =>
          PurchaseConfirmationPage(),
      'purchase_made_page': (BuildContext context) => PurchaseMadePage(),
      'billing_address_page': (BuildContext context) => BillingAddressPage(),
      'notification_page': (BuildContext context) => NotificationPage(),
      'account_page': (BuildContext context) => ProfilePage(),
      'favorite_page': (BuildContext context) => FavoritePage(),
      'frequent_questions_page' : (BuildContext context) => FrequentQuetionsPage(),
      'contact_web_page' : (BuildContext context) => ContactWebPage(),
      'terms_privacy_page' : (BuildContext context) => TermsPrivacyPage(),
      'info_page' : (BuildContext context) => InfoPage(),
      'detail_order': (BuildContext context) => DetailOrder(),
      'details_profile': (BuildContext context) => DetailsProfilePage(),
      'edit_profile': (BuildContext context) => EditProfilePage(),
      'list_billing_address_page': (BuildContext context) => ListBillingAddressPage(),
      'list_delivery_address_page': (BuildContext context) => ListDeliveryAddressPage(),
    };
