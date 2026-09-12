import 'package:flutter/material.dart';

class EnterprisePlaygroundDashboardScreen extends StatefulWidget {
  const EnterprisePlaygroundDashboardScreen({super.key});

  @override
  State<EnterprisePlaygroundDashboardScreen> createState() =>
      _EnterprisePlaygroundDashboardScreenState();
}

class _EnterprisePlaygroundDashboardScreenState
    extends State<EnterprisePlaygroundDashboardScreen> {
  final int _currentCarouselIndex =
      1; // Tracks current carousel indicator active page state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.black, // Dark layout background core palette theme
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Core Stack Hero Header Panel
            Stack(
              alignment: Alignment.topCenter,
              children: [
                // Background Imagery Source Layer
                Container(
                  height: MediaQuery.of(context).size.height * 0.76,
                  width: double.infinity,
                  foregroundDecoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black54,
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black,
                      ],
                      stops: [0.0, 0.2, 0.75, 1.0],
                    ),
                  ),
                  child: Image.asset(
                    'assets/images/dashboard_hero.jpg', // Your absolute local path reference
                    fit: BoxFit.cover,
                  ),
                ),

                // Top Fixed Overlaid Navigation Layout Elements
                SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      // Core Title Renamed to Enterprise UI Playground
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Enterprise UI Playground',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                22, // Adjusted down slightly for elegant multi-word text sizing
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Horizontal Category Filtering Tabs Strip
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _buildCategoryTabs([
                          'Shows',
                          'Movies',
                          'Sports',
                          'News',
                        ]),
                      ),
                    ],
                  ),
                ),

                // Bottom Content Title Overlay Controls
                Positioned(
                  bottom: 0,
                  left: 20,
                  right: 20,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'ENTERPRISE ORIGINAL',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2.0,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Title Layout Wrapper Block
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2.5),
                        ),
                        child: const Column(
                          children: [
                            Text(
                              'ALL STAR',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.0,
                              ),
                            ),
                            Text(
                              'SHORE',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 5.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Watch Now Operational CTA Button Widget
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white24,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: const Text(
                            'WATCH NOW',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'NEW SERIES NOW STREAMING',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Subtitle update matching new branding requirements
                      const Text(
                        'Exclusively on Enterprise UI Playground',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Horizontal Paginated Dot Matrix List Indicators
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          6,
                          (index) => _buildCarouselIndicator(index),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // 2. Secondary Bottom Brands Section Content Shelf
            const Padding(
              padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 12.0),
              child: Text(
                'Brands',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Brand Channel Selection Horizontal Cards Splitting Node
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 52,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0057B8),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          bottomLeft: Radius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Container(
                      height: 52,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF8200),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(4),
                          bottomRight: Radius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),

      // 3. Dark Semi-Transparent Native Platform Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF0D0D0D),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'SEARCH'),
          BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: 'LIVE'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'MY LIST'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'MORE'),
        ],
      ),
    );
  }

  List<Widget> _buildCategoryTabs(List<String> titles) {
    return titles.map<Widget>((title) {
      return Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w700,
          shadows: [
            Shadow(
              color: Colors.black54,
              offset: Offset(0, 1),
              blurRadius: 4.0,
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildCarouselIndicator(int index) {
    final isActive = index == _currentCarouselIndex;
    return Container(
      width: 6,
      height: 6,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.white : Colors.white38,
      ),
    );
  }
}
