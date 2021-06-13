import 'package:flutter/material.dart';
import 'package:glootie_marketplace/src/shared/colors/app_colors.dart';
import 'package:intl/intl.dart';

String formatBalance(int balance) => NumberFormat.currency(
      locale: 'en-US',
      symbol: '\$ ',
    ).format(
      balance == 0 ? 0 : balance / 100,
    );

void showMessage(
  BuildContext context, {
  required String title,
  required VoidCallback onPressed,
  String? message,
}) =>
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.pinky,
        title: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        content: message != null
            ? Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              )
            : null,
        actions: [
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              primary: AppColors.pinky,
              shadowColor: AppColors.acai,
              onPrimary: Colors.white,
              elevation: 0,
            ),
            child: Text(
              'CONFIRM',
            ),
          ),
        ],
      ),
    );
