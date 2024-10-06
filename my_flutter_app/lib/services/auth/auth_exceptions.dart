// class UserNotFoundAuthException implements Exception {}

// class WrongPasswordAuthException implements Exception {}

// class WeakPasswordAuthException implements Exception {}

// class EmailAlreadyInUseAuthException implements Exception {}

// class InvalidEmailAuthException implements Exception {}

// class GenericAuthException implements Exception {}

// class UserNotLoggedInAuthException implements Exception {}
// auth_exceptions.dart

// Exception thrown when the user tries to register with a weak password.
class WeakPasswordAuthException implements Exception {}

// Exception thrown when the user tries to register with an email that is already in use.
class EmailAlreadyInUseAuthException implements Exception {}

// Exception thrown when the user tries to register or log in with an invalid email address.
class InvalidEmailAuthException implements Exception {}

// Exception thrown when the user tries to log in with a non-existent email.
class UserNotFoundAuthException implements Exception {}

// Exception thrown when the user provides an incorrect password.
class WrongPasswordAuthException implements Exception {}

// Exception thrown for generic authentication errors that don’t fall into specific categories.
class GenericAuthException implements Exception {}

// Exception thrown when the user is not logged in but tries to perform actions that require authentication.
class UserNotLoggedInAuthException implements Exception {}
