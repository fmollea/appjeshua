import 'package:appjeshua/src/presentation/pages/add_billing_address_page.dart';
import 'package:appjeshua/src/presentation/pages/add_delivery_address_page.dart';
import 'package:appjeshua/src/presentation/pages/billing_address_page.dart';
import 'package:appjeshua/src/presentation/pages/delivery_point_page.dart';
import 'package:appjeshua/src/presentation/pages/detail_product.dart';
import 'package:appjeshua/src/presentation/pages/edit_billing_page.dart';
import 'package:appjeshua/src/presentation/pages/edit_delivery_page.dart';
import 'package:appjeshua/src/presentation/pages/forget_password_page.dart';
import 'package:appjeshua/src/presentation/pages/help_page.dart';
import 'package:appjeshua/src/presentation/pages/history_order_page.dart';
import 'package:appjeshua/src/presentation/pages/home_page.dart';
import 'package:appjeshua/src/presentation/pages/login_page.dart';
import 'package:appjeshua/src/presentation/pages/main_page.dart';
import 'package:appjeshua/src/presentation/pages/payment_method_page.dart';
import 'package:appjeshua/src/presentation/pages/pills_page.dart';
import 'package:appjeshua/src/presentation/pages/products_list.dart';
import 'package:appjeshua/src/presentation/pages/profile_billings_page.dart';
import 'package:appjeshua/src/presentation/pages/profile_delivery_page.dart';
import 'package:appjeshua/src/presentation/pages/purchase_confirmation_page.dart';
import 'package:appjeshua/src/presentation/pages/purchase_made_page.dart';
import 'package:appjeshua/src/presentation/pages/purchase_summary_page.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getApplicationRoutes() => <String, WidgetBuilder>{
      '/': (BuildContext context) => HomePage(),
      'login': (BuildContext context) => LoginPage(),
      'main_page': (BuildContext context) => MainPage(),
      'forget_pass_page': (BuildContext context) => ForgetPasswordPage(),
      'pills_page': (BuildContext context) => PillsPage(),
      'help_page': (BuildContext context) => HelpPage(),
      'products_page': (BuildContext context) => ProductsListPage(),
      'products_detail_page': (BuildContext context) => DetailProductPage(),
      'purchase_summary_page': (BuildContext context) => PurchaseSumaryPage(),
      'delivery_point_page': (BuildContext context) => DeliveryPointPage(),
      'profile_billings_page': (BuildContext context) => ProfileBillingsPage(),
      'edit_billings_page': (BuildContext context) => EditBillingPage(),
      'profile_delivery_page': (BuildContext context) => ProfileDeliveryPage(),
      'edit_delivery_page': (BuildContext context) => EditDeliveryPage(),
      'history_order_page': (BuildContext context) => HistoryOrderPage(),
      'add_deliver_address_page': (BuildContext context) =>
          AddDeliveryAddressPage(),
      'add_billing_address_page': (BuildContext context) =>
          AddBillingAddressPage(),
      'payment_method_page': (BuildContext context) => PaymentMethodPage(),
      'purchase_confirmation_page': (BuildContext context) =>
          PurchaseConfirmationPage(),
      'purchase_made_page': (BuildContext context) => PurchaseMadePage(),
      'billing_address_page': (BuildContext context) => BillingAddressPage(),
      /*
  
  'frequent_questions_page'     : (BuildContext context) => FrequentQuetionsPage(),
  'contact_web_page'            : (BuildContext context) => ContactWebPage(),
  'terms_privacy_page'          : (BuildContext context) => TermsPrivacyPage(),
  'info_page'                   : (BuildContext context) => InfoPage(),
  'selected_lift_page'          : (BuildContext context) => SelectLiftPage(),
  'personal_info_page': (BuildContext context) => PersonalInfoPage(),
  'edit_profile': (BuildContext context) => EditProfilePage(),
  */
    };
