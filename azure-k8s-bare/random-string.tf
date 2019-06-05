resource "random_string" "password" {
  length = 16
  special = true
  override_special = "!%^[]{}"
}