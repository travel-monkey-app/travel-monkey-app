// ignore_for_file: constant_identifier_names, non_constant_identifier_names

enum EnvironmentType { prod, staging, dev }

class Environment {
  static final Environment _instance = Environment._init();
  static Environment get instance => _instance;
  Environment._init();

  static String API_VERSION = "v1";

  // https://travel-monkey-app-backend-staging.azurewebsites.net/api/user-auth/v1/user-registration/

  static const String STAGING_BASE_URL =
      "https://travel-monkey-app-backend-staging.azurewebsites.net/api/";

  static const String PROD_BASE_URL =
      "https://travel-monkey-app-backend-staging.azurewebsites.net/api/";

  static const String DEV_BASE_URL = "http://192.168.1.181:8000/api/";

//  static const String STAGING_BASE_URL = "http://localhost:8000/api/";
  String tenant_registration_sub_url =
      "user-auth/$API_VERSION/user-registration/";
  String tenant_validate_account_sub_url =
      "user-auth/$API_VERSION/activate-account/";
  String tenant_login_sub_url = "user-auth/$API_VERSION/token/login/";
// user-auth/v1/initiate-reset-password/
  String tenant_forgot_password_url =
      "user-auth/$API_VERSION/initiate-reset-password/";

  // http://localhost:8000/api/user-auth/v1/confirm-reset-password/

  String tenant_confirm_reset_password_url =
      "user-auth/$API_VERSION/confirm-reset-password/";

  // http://localhost:8000/api/user-auth/v1/resend-otp/

  String tenant_resend_otp_url = "user-auth/$API_VERSION/resend-otp/";

  // http://localhost:8000/api/user-auth/v1/user-profile_vset/

  String tenant_user_profile_url = "user-auth/$API_VERSION/user-profile_vset/";

  // http://localhost:8000/api/user-auth/v1/user-profile_vset/

  String tenant_user_profile_update_url =
      "user-auth/$API_VERSION/user-profile_vset/";

  // http://localhost:8000/api/user-auth/v1/change-password/

  String tenant_change_password_url = "user-auth/$API_VERSION/change-password/";

  // http://localhost:8000/api/user-auth/v1/token/refresh/

  String tenant_refresh_token_url = "user-auth/$API_VERSION/token/refresh/";

  // http://localhost:8000/api/user-auth/v1/social_auth/social/google-oauth2/
  // http://localhost:8000/api/user-auth/v1/social_auth/google/

  String tenant_google_auth_url = "user-auth/$API_VERSION/social_auth/google/";

  // String tenant_google_auth_url =
  //     "user-auth/$API_VERSION/social_auth/social/google-oauth2/";

  static EnvironmentType environmentType = EnvironmentType.staging;

  String get getBaseUrl {
    switch (environmentType) {
      case EnvironmentType.staging:
        return STAGING_BASE_URL;
      case EnvironmentType.prod:
        return PROD_BASE_URL;
      case EnvironmentType.dev:
        return DEV_BASE_URL;
    }
  }
}
