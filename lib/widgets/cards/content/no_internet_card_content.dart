import 'package:flutter/material.dart';

class NoInternetCardContent extends StatefulWidget {
  final double height;
  final bool showSwipeText;
  final double threshold;
  final Map<String, dynamic>? contentProps;

  const NoInternetCardContent({
    super.key,
    required this.height,
    this.showSwipeText = false,
    this.threshold = 550,
    this.contentProps,
  });

  @override
  State<NoInternetCardContent> createState() => _InternetCardContentState();
}

class _InternetCardContentState extends State<NoInternetCardContent> {
  bool isInternetErrorEnabled = true;
  bool isDontShowAgainClicked = false;

  @override
  Widget build(final BuildContext context) {
    final cardWidth = widget.height * 4 / 7;

    return LayoutBuilder(
      builder: (final context, final constraints) {
        final isSmallScreen = widget.height < widget.threshold;

        final iconSize = isSmallScreen ? 45.0 : 70.0;
        final titleFontSize = isSmallScreen ? 18.0 : 24.0;
        final bodyFontSize = isSmallScreen ? 12.0 : 14.0;
        final buttonFontSize = isSmallScreen ? 10.0 : 14.0;
        final paddingValue = isSmallScreen ? 12.0 : 24.0;
        final horizontalTextPadding = isSmallScreen ? 4.0 : 16.0;

        return SizedBox(
          width: cardWidth,
          height: widget.height,
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF1A1A2E),
                    Color(0xFF16213E),
                  ],
                ),
                boxShadow: [
                  const BoxShadow(
                    color: Color(0x4B000000),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -50,
                    right: -30,
                    child: Icon(
                      Icons.wifi_off,
                      size: isSmallScreen ? 150 : 200,
                      color: const Color(0x0AFFFFFF),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(paddingValue),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.wifi_off,
                          size: iconSize,
                          color: Colors.white,
                        ),
                        SizedBox(height: isSmallScreen ? 12 : 24),
                        Text(
                          'Нет соединения',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: isSmallScreen ? 10 : 16),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: horizontalTextPadding),
                          child: Text(
                            'Похоже, у вас проблемы с интернетом. '
                            'Вы можете просматривать ранее сохранённых котиков.',
                            style: TextStyle(
                              color: const Color(0xCCFFFFFF),
                              fontSize: bodyFontSize,
                              height: 1.4,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: isSmallScreen ? 20 : 32),
                        if (isInternetErrorEnabled)
                          isDontShowAgainClicked
                              ? Text(
                                  'Больше не будем показывать!',
                                  style: TextStyle(
                                    color: const Color(0x99FFFFFF),
                                    fontSize: buttonFontSize,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      isDontShowAgainClicked = true;
                                    });
                                    if (widget
                                            .contentProps?['onDontShowAgain'] !=
                                        null) {
                                      widget.contentProps!['onDontShowAgain']();
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(30),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: isSmallScreen ? 12 : 24,
                                      vertical: isSmallScreen ? 8 : 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0x19FFFFFF),
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color: const Color(0x33FFFFFF),
                                      ),
                                    ),
                                    child: Text(
                                      'Больше не показывать',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: buttonFontSize,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                      ],
                    ),
                  ),
                  if (widget.showSwipeText)
                    Positioned(
                      bottom: isSmallScreen ? 15 : 30,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          const _SwipeHintText(),
                          SizedBox(height: isSmallScreen ? 4 : 8),
                          const _SwipeIcon(),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SwipeHintText extends StatelessWidget {
  const _SwipeHintText();

  @override
  Widget build(final BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 350;

    return Text(
      'Свайпните в сторону',
      style: TextStyle(
        color: const Color(0xB3FFFFFF),
        fontSize: isSmallScreen ? 14 : 16,
      ),
    );
  }
}

class _SwipeIcon extends StatelessWidget {
  const _SwipeIcon();

  @override
  Widget build(final BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 350;

    return Icon(
      Icons.swipe,
      color: const Color(0xB3FFFFFF),
      size: isSmallScreen ? 24 : 30,
    );
  }
}
