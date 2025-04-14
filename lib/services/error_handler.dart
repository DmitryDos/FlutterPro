import 'package:flutter/material.dart';

class ErrorHandler {
  static void error(final BuildContext context, final String errorMessage,
      {final VoidCallback? onRetry}) {
    _showNetworkError(
      context,
      onRetry: onRetry,
    );
  }

  static void _showNetworkError(final BuildContext context,
      {final VoidCallback? onRetry}) {
    if (context.mounted) {
      showDialog<void>(
        context: context,
        builder: (final context) => AlertDialog(
          title: const Text('Ошибка сети'),
          content: const Text(
              'Не удалось загрузить данные. Проверьте подключение к интернету.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
            if (onRetry != null)
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  onRetry();
                },
                child: const Text('Повторить'),
              ),
          ],
        ),
      );
    }
  }
}
