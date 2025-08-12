  import 'package:flutter/material.dart';
  import 'package:google_fonts/google_fonts.dart';
  import 'package:makemytrip_clone/screens/auth/login_sinup_screen.dart';
  import '../../core/theme/app_theme.dart';
  import '../../models/destination_model.dart';
  import '../../routes/app_routes.dart';
import '../../services/user_preferences.dart';
  import 'widgets/category_tabs.dart';
  import 'widgets/destination_card.dart';
  import 'widgets/promo_carousel.dart';

  class DashboardScreen extends StatefulWidget {
    const DashboardScreen({Key? key}) : super(key: key);

    @override
    State<DashboardScreen> createState() => _DashboardScreenState();
  }

  class _DashboardScreenState extends State<DashboardScreen> {
    int _selectedIndex = 0;

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    final List<Destination> popularDestinations = [
      Destination(
        name: 'Goa',
        imagePath: 'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?q=80&w=1074&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        price: '₹ 15,000',
      ),
      Destination(
        name: 'Manali',
        imagePath: 'https://plus.unsplash.com/premium_photo-1661878942694-6adaa2ce8175?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8TWFuYWxpfGVufDB8fDB8fHww',
        price: '₹ 18,000',
      ),
      Destination(
        name: 'Jaipur',
        imagePath: 'https://images.unsplash.com/photo-1603262110263-fb0112e7cc33?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8amFpcHVyfGVufDB8fDB8fHww',
        price: '₹ 12,000',
      ),
    ];

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          shadowColor: Colors.white.withOpacity(0.1),
          elevation: 2,
          title: Row(
            children: [
              Icon(Icons.location_on, color: Colors.blue.shade400),
              const SizedBox(width: 8),
              const Text('New Delhi'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: Column(
                          children: const [
                            Icon(Icons.logout, size: 50, color: Colors.red),
                            SizedBox(height: 10),
                            Text(
                              "Logout?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                        content: const Text(
                          "Are you sure you want to log out?",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade300,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel",style: GoogleFonts.poppins(color: Colors.black),),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            ),
                            onPressed: () {
                              AuthService.logout();
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                AppRoutes.login,
                                    (route) => false,
                              );
                            },

                            child: Text("Logout",style: GoogleFonts.poppins(color: Colors.white),),
                          ),
                        ],
                      );
                    },
                  );
                }

            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CategoryTabs(),
              const SizedBox(height: 16),
              const PromoCarousel(),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Popular Destinations',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: popularDestinations.length,
                  itemBuilder: (context, index) {
                    return DestinationCard(destination: popularDestinations[index]);
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Bookings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_offer),
              label: 'Offers',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          onTap: _onItemTapped,
        ),
      );
    }
  }