import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _buttonController;
  
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<Offset> _textSlide;
  late Animation<double> _textOpacity;
  late Animation<double> _buttonScale;
  late Animation<double> _buttonOpacity;

  @override
  void initState() {
    super.initState();
    
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _logoScale = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));
    
    _logoOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));
    
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOut,
    ));
    
    _textOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
    ));
    
    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _buttonScale = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _buttonController,
      curve: Curves.elasticOut,
    ));
    
    _buttonOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _buttonController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
    ));
    
    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _logoController.forward();
    
    await Future.delayed(const Duration(milliseconds: 800));
    _textController.forward();
    
    await Future.delayed(const Duration(milliseconds: 600));
    _buttonController.forward();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    
    final isTablet = screenSize.width > 600;
    final isLandscape = screenSize.width > screenSize.height;
    final isSmallScreen = screenSize.height < 600;
    final isVerySmallScreen = screenSize.height < 500;
    final isLargeScreen = screenSize.height > 800;
    final isExtraLargeScreen = screenSize.height > 1000;
    
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final minDimension = screenWidth < screenHeight ? screenWidth : screenHeight;
    
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemBackground,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.primary.withOpacity(0.05),
            ],
          ),
        ),
        child: SafeArea(
          child: isTablet && isLandscape 
            ? _buildTabletLandscapeLayout(context, screenSize)
            : _buildMobileLayout(context, screenSize, isSmallScreen, isVerySmallScreen, isLargeScreen, isExtraLargeScreen, minDimension),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, Size screenSize, bool isSmallScreen, bool isVerySmallScreen, bool isLargeScreen, bool isExtraLargeScreen, double minDimension) {
    final padding = isVerySmallScreen ? 8.0 : isSmallScreen ? 12.0 : isLargeScreen ? 24.0 : 20.0;
    final spacing = isVerySmallScreen ? 8.0 : isSmallScreen ? 12.0 : isLargeScreen ? 30.0 : 20.0;
    
    final contentPadding = EdgeInsets.symmetric(
      horizontal: padding,
      vertical: isVerySmallScreen ? 8.0 : 16.0,
    );
    
    return SingleChildScrollView(
      padding: contentPadding,
      physics: const BouncingScrollPhysics(),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: screenSize.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: isVerySmallScreen ? 5 : isSmallScreen ? 10 : spacing),
            _buildLogo(context, isSmallScreen, isVerySmallScreen, isLargeScreen, minDimension),
            SizedBox(height: isVerySmallScreen ? 10 : isSmallScreen ? 15 : 25),
            _buildTitleSection(context, isSmallScreen, isVerySmallScreen, isLargeScreen),
            SizedBox(height: isVerySmallScreen ? 10 : isSmallScreen ? 15 : 25),
            _buildFeaturesSection(context, isSmallScreen, isVerySmallScreen, isLargeScreen),
            SizedBox(height: isVerySmallScreen ? 15 : isSmallScreen ? 20 : 30),
            _buildActionButtons(context, isSmallScreen, isVerySmallScreen, isLargeScreen),
            SizedBox(height: isVerySmallScreen ? 5 : isSmallScreen ? 10 : 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletLandscapeLayout(BuildContext context, Size screenSize) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLogo(context, false, false, true, screenSize.width),
                const SizedBox(height: 40),
                _buildTitleSection(context, false, false, true),
                const SizedBox(height: 40),
                _buildActionButtons(context, false, false, true),
              ],
            ),
          ),
          const SizedBox(width: 60),
          Expanded(
            flex: 1,
            child: _buildFeaturesSection(context, false, false, true),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo(BuildContext context, bool isSmallScreen, bool isVerySmallScreen, bool isLargeScreen, double minDimension) {
    final baseLogoSize = isVerySmallScreen ? 50.0 : isSmallScreen ? 60.0 : isLargeScreen ? 120.0 : 100.0;
    final logoSize = (baseLogoSize * (minDimension / 400)).clamp(40.0, 150.0);
    final iconSize = logoSize * 0.5;
    
    return AnimatedBuilder(
      animation: _logoController,
      builder: (context, child) {
        return Transform.scale(
          scale: _logoScale.value,
          child: Opacity(
            opacity: _logoOpacity.value,
            child: Container(
              width: logoSize,
              height: logoSize,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary.withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(logoSize * 0.25),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    blurRadius: logoSize * 0.3,
                    spreadRadius: logoSize * 0.05,
                    offset: Offset(0, logoSize * 0.1),
                  ),
                ],
              ),
              child: Icon(
                Icons.explore,
                size: iconSize,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitleSection(BuildContext context, bool isSmallScreen, bool isVerySmallScreen, bool isLargeScreen) {
    final titleFontSize = isVerySmallScreen ? 22.0 : isSmallScreen ? 26.0 : isLargeScreen ? 38.0 : 30.0;
    final subtitleFontSize = isVerySmallScreen ? 14.0 : isSmallScreen ? 16.0 : isLargeScreen ? 20.0 : 18.0;
    
    return AnimatedBuilder(
      animation: _textController,
      builder: (context, child) {
        return SlideTransition(
          position: _textSlide,
          child: FadeTransition(
            opacity: _textOpacity,
            child: Column(
              children: [
                Text(
                  'Experience Mapper',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: titleFontSize,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: isVerySmallScreen ? 6 : isSmallScreen ? 8 : 16),
                Text(
                  'Map your memories, one location at a time',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w400,
                    fontSize: subtitleFontSize,
                    height: 1.3,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeaturesSection(BuildContext context, bool isSmallScreen, bool isVerySmallScreen, bool isLargeScreen) {
    return AnimatedBuilder(
      animation: _textController,
      builder: (context, child) {
        return SlideTransition(
          position: _textSlide,
          child: FadeTransition(
            opacity: _textOpacity,
            child: Column(
              children: [
                _buildFeatureItem(
                  context: context,
                  icon: Icons.location_on,
                  title: 'Pin Your Memories',
                  description: 'Mark special places and moments',
                  isSmallScreen: isSmallScreen,
                  isVerySmallScreen: isVerySmallScreen,
                  isLargeScreen: isLargeScreen,
                ),
                SizedBox(height: isVerySmallScreen ? 6 : isSmallScreen ? 8 : 12),
                _buildFeatureItem(
                  context: context,
                  icon: Icons.notes,
                  title: 'Add Personal Notes',
                  description: 'Capture the details of each experience',
                  isSmallScreen: isSmallScreen,
                  isVerySmallScreen: isVerySmallScreen,
                  isLargeScreen: isLargeScreen,
                ),
                SizedBox(height: isVerySmallScreen ? 6 : isSmallScreen ? 8 : 12),
                _buildFeatureItem(
                  context: context,
                  icon: Icons.timeline,
                  title: 'Track Your Journey',
                  description: 'See your life story unfold on the map',
                  isSmallScreen: isSmallScreen,
                  isVerySmallScreen: isVerySmallScreen,
                  isLargeScreen: isLargeScreen,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButtons(BuildContext context, bool isSmallScreen, bool isVerySmallScreen, bool isLargeScreen) {
    final buttonHeight = isVerySmallScreen ? 44.0 : isSmallScreen ? 48.0 : isLargeScreen ? 56.0 : 52.0;
    final buttonFontSize = isVerySmallScreen ? 14.0 : isSmallScreen ? 16.0 : isLargeScreen ? 18.0 : 16.0;
    final iconSize = isVerySmallScreen ? 18.0 : isSmallScreen ? 20.0 : isLargeScreen ? 24.0 : 22.0;
    
    return AnimatedBuilder(
      animation: _buttonController,
      builder: (context, child) {
        return Transform.scale(
          scale: _buttonScale.value,
          child: Opacity(
            opacity: _buttonOpacity.value,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: buttonHeight,
                  child: CupertinoButton.filled(
                    onPressed: _startApp,
                    padding: EdgeInsets.symmetric(
                      vertical: isVerySmallScreen ? 8 : isSmallScreen ? 12 : 16,
                      horizontal: 24,
                    ),
                    borderRadius: BorderRadius.circular(isVerySmallScreen ? 12 : 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.rocket_launch, 
                          size: iconSize,
                        ),
                        SizedBox(width: isVerySmallScreen ? 6 : isSmallScreen ? 8 : 12),
                        Text(
                          'Start Your Journey',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: buttonFontSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: isVerySmallScreen ? 8 : isSmallScreen ? 12 : 20),
                CupertinoButton(
                  onPressed: _startApp,
                  padding: EdgeInsets.symmetric(
                    vertical: isVerySmallScreen ? 8 : 12,
                    horizontal: 16,
                  ),
                  child: Text(
                    'Skip Introduction',
                    style: TextStyle(
                      color: CupertinoColors.systemBlue,
                      fontSize: isVerySmallScreen ? 12 : isSmallScreen ? 14 : 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeatureItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required bool isSmallScreen,
    required bool isVerySmallScreen,
    required bool isLargeScreen,
  }) {
    final iconSize = isVerySmallScreen ? 32.0 : isSmallScreen ? 36.0 : isLargeScreen ? 56.0 : 48.0;
    final iconInnerSize = isVerySmallScreen ? 16.0 : isSmallScreen ? 18.0 : isLargeScreen ? 28.0 : 24.0;
    final padding = isVerySmallScreen ? 6.0 : isSmallScreen ? 8.0 : isLargeScreen ? 20.0 : 16.0;
    final titleFontSize = isVerySmallScreen ? 12.0 : isSmallScreen ? 14.0 : isLargeScreen ? 18.0 : 16.0;
    final descriptionFontSize = isVerySmallScreen ? 10.0 : isSmallScreen ? 12.0 : isLargeScreen ? 16.0 : 14.0;
    
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(isVerySmallScreen ? 12 : 16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: iconSize,
            height: iconSize,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(isVerySmallScreen ? 8 : 12),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
              size: iconInnerSize,
            ),
          ),
          SizedBox(width: isVerySmallScreen ? 8 : isSmallScreen ? 12 : 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: titleFontSize,
                    color: Theme.of(context).colorScheme.onSurface,
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(height: isVerySmallScreen ? 1 : isSmallScreen ? 2 : 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: descriptionFontSize,
                    height: 1.3,
                    decoration: TextDecoration.none,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _startApp() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }
}
