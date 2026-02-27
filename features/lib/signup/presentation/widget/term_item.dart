import 'package:design_system/theme/color_palette.dart';
import 'package:features/signup/domain/entities/oidc_signup_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TermItem extends StatelessWidget {
  final TermAgreementItem term;
  final VoidCallback onToggle;

  const TermItem({super.key, required this.term, required this.onToggle});

  // const _TermItem({required this.term, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: onToggle,
            child: Icon(
              term.isAgreed
                  ? Icons.check_circle_rounded
                  : Icons.check_circle_outline_rounded,
              color: term.isAgreed
                  ? ColorPalette.orangePrimary
                  : ColorPalette.greyDark,
              size: 22,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              term.title,
              style:
              const TextStyle(fontFamily: 'gmarketSans', fontSize: 14),
            ),
          ),
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: term.isRequired
                  ? ColorPalette.orangeVeryLight
                  : ColorPalette.greyLight,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              term.isRequired ? '필수' : '선택',
              style: TextStyle(
                fontFamily: 'gmarketSans',
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: term.isRequired
                    ? ColorPalette.orangeDeep
                    : ColorPalette.greyDark,
              ),
            ),
          ),
          if (term.linkUrl.isNotEmpty) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => _launchUrl(term.linkUrl),
              child: const Icon(
                Icons.open_in_new,
                size: 16,
                color: ColorPalette.greyDark,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

Future<void> _launchUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.platformDefault);
  }
}