import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';

/// Elige galería o cámara, con el aviso de derechos de uso (ADR-005).
Future<ImageSource?> showImageSourceSheet(BuildContext context) =>
    showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context);
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text(
                  l10n.roofImageRightsNotice,
                  key: const Key('roof-rights-notice'),
                ),
                subtitle: Text(l10n.roofImageTopViewHint),
              ),
              ListTile(
                key: const Key('roof-source-gallery'),
                leading: const Icon(Icons.photo_library),
                title: Text(l10n.roofSourceGallery),
                onTap: () => Navigator.of(context).pop(ImageSource.gallery),
              ),
              ListTile(
                key: const Key('roof-source-camera'),
                leading: const Icon(Icons.photo_camera),
                title: Text(l10n.roofSourceCamera),
                onTap: () => Navigator.of(context).pop(ImageSource.camera),
              ),
            ],
          ),
        );
      },
    );
