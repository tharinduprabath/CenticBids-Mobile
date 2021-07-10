enum ErrorCode {
  e_1000, // unknown_failure
  e_1100, // unknown_server_failure
  e_1200, // network_failure
  e_1500, // unknown_auth_failure
  e_1510, // user_not_found_auth_failure
  e_1520, // uid_already_exists_auth_failure
  e_1530, // email_already_exists_auth_failure
  e_1540, // insufficient_permission_auth_failure
  e_1550, // invalid_email_auth_failure
  e_1560, // invalid_password_auth_failure
  e_1590, // wrong_password_auth_failure
  e_1591, // email_not_verified_auth_failure
  e_1592, // wrong_current_password_auth_failure
  e_2010, // bid_place_failed_auction_over_auction_failure
  e_2020, // bid_place_failed_has_new_latest_bid_auction_failure
}
