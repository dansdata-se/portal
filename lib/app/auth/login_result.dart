enum LoginResult {
  /// The login was a success - user is now logged in
  success,

  /// The login failed due to invalid credentials
  invalidCredentials,

  /// The login failed due to an error
  error,

  /// The login attempt was aborted, e.g. because another login is already in
  /// progress.
  aborted,
}
