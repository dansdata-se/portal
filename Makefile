## Syntax: make <command>
## --

help:                               ## Show this help
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)

get-started:                        ## First time setup (install packages, run code generators etc.)
get-started: pub-get generate
get-started:
	flutterfire configure

## ====== Utilities ======

fix:                                ## Automatically fix simple analysis problems
_fix:
	dart fix --apply
fix: _fix format

fix-dry:                            ## Preview fixes for simple analysis problems
fix-dry:
	dart fix --dry-run

format:                             ## Format files
format:
	dart format .

generate:                           ## Run code generators
generate: _l10n
	dart run build_runner build --delete-conflicting-outputs

l10n:                               ## Generate and verify localization files
_l10n:
	# Create build directory if it does not exist.
	# Otherwise, `flutter gen-l10n` will throw
	# PathNotFoundException: Cannot open file, path = 'build/l10n_errors.json' (OS Error: No such file or directory, errno = 2)
	mkdir -p build/
	flutter gen-l10n
l10n: _l10n check-translations

pub-get:                            ## Shorthand for `flutter pub get`
pub-get:
	flutter pub get

## ====== Verification ======

check:                              ## Run all `check` tasks
check: check-translations check-formatting check-analyze check-test

check-analyze:                      ## Perform code analysis
check-analyze: generate
	flutter analyze

check-formatting:                   ## Validate code formatting
check-formatting:
	dart format --set-exit-if-changed .

check-test:                         ## Run tests
check-test: generate
	flutter test

check-translations:                 ## Run all translation checks
check-translations: generate check-translations-missing check-translations-sorted

check-translations-missing:         ## Check for missing translations
check-translations-missing:
	scripts/check-translations-missing.sh

check-translations-sorted:          ## Validate that translation keys are sorted
check-translations-sorted:
	scripts/check-translations-sorted.sh

## ====== Build ======

clean:                              ## Delete build artifacts
clean:
	dart run build_runner clean
	flutter clean

build:                              ## Build for all supported platforms
build: build-android build-ios build-web

build-android:                      ## Build for Android
build-android: generate
	flutter build apk --obfuscate --split-per-abi --split-debug-info=build/app/debug-info
	flutter build appbundle --obfuscate --split-debug-info=build/app/debug-info

build-ios:                          ## Build for iOS
build-ios: generate
	flutter build ipa --obfuscate --split-debug-info=build/ios/debug-info

build-web:                          ## Build for web
build-web: generate
	flutter build web
