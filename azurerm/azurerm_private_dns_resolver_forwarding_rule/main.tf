locals {
  name = length(var.name != null ? var.name : "") > 0 ? var.name : "rule"
}
resource "azurerm_private_dns_resolver_forwarding_rule" "this" {
  dns_forwarding_ruleset_id = var.dns_forwarding_ruleset_id
  domain_name = var.domain_name
  enabled     = var.enabled
  metadata = {
    key = "value"
  }
  name                 = local.name
  target_dns_servers {
    ip_address = "10.10.0.1"
    port       = 53
  }
}