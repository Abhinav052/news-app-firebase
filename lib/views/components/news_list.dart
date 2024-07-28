import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsList extends StatelessWidget {
  final List<dynamic> newsList;

  String timeAgo(String publishedAt) {
    final DateTime publishedDate = DateTime.parse(publishedAt);
    final Duration difference = DateTime.now().difference(publishedDate);

    if (difference.inDays > 8) {
      return DateFormat('MMM d, y').format(publishedDate); // Example: 'Jul 28, 2024'
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }

  NewsList({required this.newsList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: newsList.length,
      itemBuilder: (context, index) {
        final news = newsList[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.white,
          shadowColor: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        news["source"]["name"],
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 5),
                      Text(
                        news["title"],
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        timeAgo(news["publishedAt"]),
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'https://plus.unsplash.com/premium_photo-1688561384438-bfa9273e2c00?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', // Placeholder for image URL
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
