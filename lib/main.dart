import "package:flutter/material.dart";
import "package:portal/app/app.dart";
import "package:portal/vercel/vercel_env.dart";

// Note that <Primitive>.fromEnvironment loads its variables at build time!
// https://github.com/dart-lang/sdk/issues/27585
class BuildConfig {
  static final Uri supabaseUrl = Uri.parse(
    const String.fromEnvironment(
      "SUPABASE_URL",
      defaultValue: "http://localhost:54321",
    ),
  );
  static const String supabaseAnonKey = String.fromEnvironment(
    "SUPABASE_ANON_KEY",
    defaultValue:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24ifQ.625_WdcF3KHqz5amU0x2X5WWHP-OEs_4qj0ssLNHzTs",
  );
  static final VercelEnv vercelEnv = VercelEnv.values.byName(
    const String.fromEnvironment(
      "VERCEL_ENV",
      defaultValue: "development",
    ),
  );
  static const String gitCommitRef = String.fromEnvironment(
    "GIT_COMMIT_REF",
    defaultValue: "unknown",
  );
  static const String gitCommitSha = String.fromEnvironment(
    "GIT_COMMIT_SHA",
    defaultValue: "unknown",
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
