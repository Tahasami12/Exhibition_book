
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit()
      : super(
    NotificationState(
      deliveries: const [
        NotificationTabData(
          film: 'The Da vinci Code',
          status: 'On the way',
          quantity: '1 item',
          poster: 'assets/images/Image.png',
        ),
        NotificationTabData(
          film: 'Carrie Fisher',
          status: 'Delivered',
          quantity: '1 item',
          poster: 'assets/images/Rectangle.png',
        ),
        NotificationTabData(
          film: 'The Waiting',
          status: 'Delivered',
          quantity: '5 items',
          poster: 'assets/images/Rectanglee.png',
        ),
        NotificationTabData(
          film: 'Bright Young',
          status: 'Cancelled',
          quantity: '2 items',
          poster: 'assets/images/Ractangleee.png',
        ),
      ],
      news: const [
        NewsItem(
          type: 'promotion',
          date: 'Oct 24',
          time: '08.00',
          description: 'fifty_percent_discount',
        ),
        NewsItem(
          type: 'promotion',
          date: 'Oct 08',
          time: '20.30',
          description: 'buy_2_get_1_free',
        ),
        NewsItem(
          type: 'information',
          date: 'Sept 16',
          time: '11.00',
          description: 'new_book_available',
        ),
      ],
    ),
  );
}
