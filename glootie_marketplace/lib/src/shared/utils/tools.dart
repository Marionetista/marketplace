import 'package:intl/intl.dart';

String formatBalance(int balance) => NumberFormat.currency(
      locale: 'en-US',
      symbol: '\$ ',
    ).format(
      balance == 0 ? 0 : balance / 100,
    );
