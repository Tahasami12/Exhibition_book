import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/responsive.dart';
import '../../../home/presentation/views/home_view.dart';

class OrderReceivedScreen extends StatefulWidget {
  const OrderReceivedScreen({super.key});

  @override
  State<OrderReceivedScreen> createState() => _OrderReceivedScreenState();
}

class _OrderReceivedScreenState extends State<OrderReceivedScreen> {
  int _rating = 4;
  final TextEditingController _feedbackController = TextEditingController();

  late int _orderNumber; // رقم الأوردر العشوائي

  @override
  void initState() {
    super.initState();
    // توليد رقم عشوائي من 7 أرقام
    _orderNumber = 1000000 + Random().nextInt(9000000);
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = Responsive.maxContentWidth(context);
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxWidth ?? double.infinity,
              ),
              child: SingleChildScrollView(
                padding: Responsive.responsivePadding(context),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: Responsive.responsiveSpacing(context, 20)),

                    // Gift Box Image from assets
                    Container(
                      padding: EdgeInsets.all(Responsive.responsiveSpacing(context, 20)),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C47FF).withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(
                          Responsive.responsiveBorderRadius(context, 60),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          Responsive.responsiveBorderRadius(context, 40),
                        ),
                        child: Image.asset(
                          'assets/images/img1.jpg',
                          width: Responsive.responsiveImageSize(context, 80),
                          height: Responsive.responsiveImageSize(context, 80),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    SizedBox(height: Responsive.responsiveSpacing(context, 24)),

                    // Order Confirmation Text
                    Text(
                      'You Received The Order!',
                      style: TextStyle(
                        fontSize: Responsive.responsiveFontSize(context, 24),
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: Responsive.responsiveSpacing(context, 8)),

                    // 🔢 رقم الأوردر العشوائي
                    Text(
                      'Order #$_orderNumber',
                      style: TextStyle(
                        fontSize: Responsive.responsiveFontSize(context, 16),
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: Responsive.responsiveSpacing(context, 32)),

                    // Feedback Card
                    Container(
                      padding: EdgeInsets.all(Responsive.responsiveSpacing(context, 20)),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C47FF).withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(
                          Responsive.responsiveBorderRadius(context, 16),
                        ),
                        border: Border.all(
                          color: const Color(0xFF6C47FF).withValues(alpha: 0.1),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tell us your feedback ✨',
                            style: TextStyle(
                              fontSize: Responsive.responsiveFontSize(context, 18),
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF6C47FF),
                            ),
                          ),

                          SizedBox(height: Responsive.responsiveSpacing(context, 8)),

                          // ⭐ Star Rating - Click to select
                          Row(
                            children: List.generate(5, (index) {
                              final isSelected = index < _rating;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _rating = index + 1;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    right: Responsive.responsiveSpacing(context, 8),
                                  ),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    child: Icon(
                                      Icons.star,
                                      color: isSelected
                                          ? Colors.amber
                                          : Colors.grey.withValues(alpha: 0.3),
                                      size: Responsive.responsiveIconSize(context, 32),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: Responsive.responsiveSpacing(context, 8)),
                          Text(
                            '$_rating out of 5 stars',
                            style: TextStyle(
                              fontSize: Responsive.responsiveFontSize(context, 14),
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          SizedBox(height: Responsive.responsiveSpacing(context, 16)),

                          // Feedback Text Field
                          TextFormField(
                            controller: _feedbackController,
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                              fontSize: Responsive.responsiveFontSize(context, 14),
                            ),
                            decoration: InputDecoration(
                              hintText: 'Write something for us!',
                              hintStyle: TextStyle(
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? Colors.grey[500]!
                                    : Colors.grey[600]!,
                                fontSize: Responsive.responsiveFontSize(context, 14),
                              ),
                              filled: true,
                              fillColor: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.grey[900]!
                                  : Colors.grey[50]!,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: Responsive.responsiveSpacing(context, 16),
                                vertical: Responsive.responsiveSpacing(context, 16),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? Colors.grey[700]!
                                      : Colors.grey[300]!,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? Colors.grey[700]!
                                      : Colors.grey[300]!,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Color(0xFF6C47FF), width: 2),
                              ),
                            ),
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: Responsive.responsiveSpacing(context, 32)),

                    // Done Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to home and clear all previous routes
                          Get.offAll(() => const HomeView());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C47FF),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            vertical: Responsive.responsiveSpacing(context, 16),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              Responsive.responsiveBorderRadius(context, 12),
                            ),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Done',
                          style: TextStyle(
                            fontSize: Responsive.responsiveFontSize(context, 16),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Responsive.responsiveSpacing(context, 20)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
