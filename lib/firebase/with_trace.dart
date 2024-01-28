import "dart:async";

import "package:firebase_performance/firebase_performance.dart";

extension TraceBlock on FirebasePerformance {
  Future<R> withTrace<R>(
    String name,
    FutureOr<R> Function() block, {
    void Function(Trace)? configureTrace,
  }) async {
    final trace = newTrace(name);
    if (configureTrace != null) configureTrace(trace);
    await trace.start();
    try {
      final returnValue = await block();
      trace.putAttribute("SUT_execution_error", "false");
      return returnValue;
    } catch (_) {
      // SUT - System Under Test
      trace.putAttribute("SUT_execution_error", "true");
      rethrow;
    } finally {
      await trace.stop();
    }
  }
}
