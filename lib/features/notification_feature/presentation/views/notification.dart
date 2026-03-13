import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../view_model/notification_state.dart';
import '../view_model/notification_view_model.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
  create: (context) => NotificationViewModel(),
  child: DefaultTabController(
    length: 2,
    child: Scaffold(
        appBar: _AppBar(width: width),
        body: const _NotificationTabs(),
      ),
  ),
);
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({super.key, required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: InkWell(
        onTap: () {
          Get.back();
        },
        child: const Icon(Icons.arrow_back),
      ),
      title: const Text(
        'Notification',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      bottom: const TabBar(tabs: [Tab(text: 'Delivery'), Tab(text: 'News')]),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(104);
}

class _NotificationTabs extends StatelessWidget {
  const _NotificationTabs();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final isTablet = width > 600;

    return BlocBuilder<NotificationViewModel, NotificationState>(
      builder: (context, state) {
        return TabBarView(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05,
                  vertical: height * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.03),
                    Text(
                      'Current',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isTablet ? 22 : 18,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    ...state.deliveries.map(
                      (delivery) => Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.015,
                        ),
                        child: _DeliveryCard(
                          data: delivery,
                          isTablet: isTablet,
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    Text(
                      'October 2021',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isTablet ? 22 : 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05,
                  vertical: height * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.03),
                    Text(
                      'October 2021',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isTablet ? 22 : 18,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    InkWell(
                      onTap: () {
                        //Get.to(const PromotionPage());
                      },
                      child: _NewsRow(
                        item: state.news.first,
                        isTablet: isTablet,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    const Text(
                      '50% discount',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: height * 0.02),
                    Image.asset("assets/images/Line.png"),
                    SizedBox(height: height * 0.02),
                    ...state.news
                        .skip(1)
                        .map(
                          (item) => Padding(
                            padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.015,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _NewsRow(item: item, isTablet: isTablet),
                                SizedBox(height: height * 0.01),
                                Text(
                                  _newsDescription(item.description),
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                    SizedBox(height: height * 0.03),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String _newsDescription(String key) {
    switch (key) {
      case 'fifty_percent_discount':
        return 'October 2021 50% discount on selected novels.';
      case 'buy_2_get_1_free':
        return 'Buy 2 Get 1 Free - valid for a limited time.';
      case 'new_book_available':
        return 'A new book is now available.';
      default:
        return key;
    }
  }
}

class _DeliveryCard extends StatelessWidget {
  const _DeliveryCard({required this.data, required this.isTablet});

  final NotificationTabData data;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final Map<String, Color> statusColors = {
      "on the way": const Color(0xFF3784FB),
      "delivered": const Color(0XFF18A057),
      "cancelled": const Color(0XFFEF5A56),
    };
    final statusColor = statusColors[data.status.toLowerCase()] ?? Colors.black;

    return Container(
      margin: EdgeInsets.only(bottom: height * 0.02),
      padding: EdgeInsets.all(width * 0.03),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE1DEDE)),
      ),
      child: Row(
        children: [
          Image.asset(
            data.poster,
            width: isTablet ? width * 0.08 : width * 0.18,
            fit: BoxFit.cover,
          ),
          SizedBox(width: width * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.film,
                  style: TextStyle(
                    fontSize: isTablet ? 18 : 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: height * 0.005),
                Row(
                  children: [
                    Text(
                      data.status,
                      style: TextStyle(
                        fontSize: isTablet ? 16 : 14,
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: width * 0.015),
                    Container(
                      height: 5,
                      width: 5,
                      decoration: const BoxDecoration(
                        color: Color(0XFFE8E8E8),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: width * 0.015),
                    Text(
                      data.quantity,
                      style: TextStyle(
                        fontSize: isTablet ? 16 : 14,
                        color: const Color(0XFF7A7A7A),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NewsRow extends StatelessWidget {
  const _NewsRow({required this.item, required this.isTablet});

  final NewsItem item;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    final Map<String, Color> textColors = {
      "promotion": const Color(0XFF54408C),
      "information": const Color(0XFF3784FB),
    };
    final textColor = textColors[item.type.toLowerCase()] ?? Colors.black;

    return Row(
      children: [
        Text(
          item.type,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isTablet ? 16 : 14,
            color: textColor,
          ),
        ),
        const Spacer(),
        Text(
          item.date,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Color(0XFFA6A6A6),
          ),
        ),
        const SizedBox(width: 6),
        Container(
          height: 5,
          width: 5,
          decoration: const BoxDecoration(
            color: Color(0XFFA6A6A6),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          item.time,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Color(0XFFA6A6A6),
          ),
        ),
      ],
    );
  }
}
