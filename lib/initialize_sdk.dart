import 'package:flutter/foundation.dart';
import 'package:localstorage/localstorage.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

initializeSdk() async {
  if(kReleaseMode){
    await SentryFlutter.init(
          (options) {
        options.dsn = 'https://4ddb02a25e66ec1419b3d217a37a8124@o4507434457235456.ingest.de.sentry.io/4507434465820752';
        // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
        // We recommend adjusting this value in production.
        options.tracesSampleRate = 0.01;
        // The sampling rate for profiling is relative to tracesSampleRate
        // Setting to 1.0 will profile 100% of sampled transactions:
        options.profilesSampleRate = 0.01;
      },
    );
    // Flutter exception
    FlutterError.onError = (details) async {
      await Sentry.captureException(details.exception, stackTrace: details.stack);
      FlutterError.presentError(details);
    };
    // Platform exception
    PlatformDispatcher.instance.onError = (error, stack) {
      Sentry.captureException(error, stackTrace: stack);
      FlutterError.presentError(FlutterErrorDetails(exception: error, stack: stack));
      return false;
    };
  }
  await initLocalStorage();
}