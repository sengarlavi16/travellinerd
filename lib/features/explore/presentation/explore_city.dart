import 'package:flutter/material.dart';
import 'package:travellinerd/core/app_constants/colors.dart';
import 'package:travellinerd/core/app_constants/strings.dart';

class ExploreCity extends StatelessWidget {
  const ExploreCity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 70,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            decoration: const BoxDecoration(
              color: AppColors.appColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: const Text(
              AppStrings.exploreCity,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.whiteColor,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 10,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                return _buildCityCard(
                  image:
                      'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=500&q=80',
                  title: 'City ${index + 1}',
                  country: 'Country ${index + 1}',
                  temp: '${20 + index}°C',
                  weatherIcon: Icons.wb_sunny,
                  weatherColor: Colors.orange,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCityCard({
    required String image,
    required String title,
    required String country,
    required String temp,
    required IconData weatherIcon,
    required Color weatherColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.network(
              image,
              height: 110,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  country,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(weatherIcon, size: 14, color: weatherColor),
                        const SizedBox(width: 4),
                        Text(
                          temp,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const Icon(Icons.bookmark_border, size: 16),
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
