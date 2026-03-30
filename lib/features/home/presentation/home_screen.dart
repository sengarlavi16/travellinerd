// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:travellinerd/core/app_constants/colors.dart';
import 'package:travellinerd/core/app_constants/strings.dart';
import 'package:travellinerd/features/home/domain/weather_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  Map<String, dynamic>? weatherData;
  bool isLoading = false;

  IconData getWeatherIcon(double temp) {
    if (temp < 15) return Icons.ac_unit;
    if (temp < 28) return Icons.wb_cloudy;
    return Icons.wb_sunny;
  }

  Color getWeatherColor(double temp) {
    if (temp < 15) return Colors.blue;
    if (temp < 28) return Colors.grey;
    return Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 30),
            _buildCategories(),
            const SizedBox(height: 30),
            _buildWeatherResult(), // 👈 changed here
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
      decoration: const BoxDecoration(
        color: AppColors.appColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.helloTraveler,
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 4),
          const Text(
            AppStrings.checkWeatherInstantly,
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildSearchInput(
                  controller: _controller,
                  icon: Icons.location_city,
                  iconColor: AppColors.appColor,
                  hintText: AppStrings.enterCity,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() => isLoading = true);

                      final data = await WeatherService().fetchWeather(
                        _controller.text,
                      );

                      setState(() {
                        weatherData = data;
                        isLoading = false;
                      });

                      if (data == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("City not found")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      AppStrings.getWeather,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchInput({
    required TextEditingController controller,
    required IconData icon,
    required Color iconColor,
    required String hintText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(icon, color: iconColor),
        hintText: hintText,
      ),
    );
  }

  Widget _buildCategories() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Icon(Icons.wb_sunny, size: 30),
          Icon(Icons.ac_unit, size: 30),
          Icon(Icons.water_drop, size: 30),
          Icon(Icons.air, size: 30),
        ],
      ),
    );
  }

  Widget _buildWeatherResult() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (weatherData == null) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Text(AppStrings.searchCityToSeeLiveWeather),
      );
    }

    final temp = weatherData!['temperature'].toDouble();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: _buildDestinationCard(
        image:
            'https://images.unsplash.com/photo-1557744948-f5a356d6d036?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTU1fHx3ZWF0aGVyJTIwdHJhdmVsfGVufDB8fDB8fHwy',
        title: _controller.text,
        country: AppStrings.liveWeather,
        temp: "${weatherData!['temperature']}°C",
        weatherIcon: getWeatherIcon(temp),
        weatherColor: getWeatherColor(temp),
      ),
    );
  }

  Widget _buildDestinationCard({
    required String image,
    required String title,
    required String country,
    required String temp,
    required IconData weatherIcon,
    required Color weatherColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Image.network(image, height: 150, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text(title, style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                Text(temp, style: const TextStyle(fontSize: 22)),
                const SizedBox(height: 10),
                Icon(weatherIcon, color: weatherColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
