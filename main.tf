resource "google_compute_router" "compute_routers" {
  for_each = var.compute_routers

  name                          = each.value.name
  deletion_policy               = each.value.deletion_policy
  description                   = each.value.description
  encrypted_interconnect_router = each.value.encrypted_interconnect_router
  ncc_gateway                   = each.value.ncc_gateway
  network                       = each.value.network
  project                       = each.value.project
  region                        = each.value.region

  dynamic "bgp" {
    for_each = each.value.bgp != null ? [each.value.bgp] : []
    content {
      advertise_mode    = bgp.value.advertise_mode
      advertised_groups = bgp.value.advertised_groups
      dynamic "advertised_ip_ranges" {
        for_each = bgp.value.advertised_ip_ranges != null ? bgp.value.advertised_ip_ranges : []
        content {
          description = advertised_ip_ranges.value.description
          range       = advertised_ip_ranges.value.range
        }
      }
      asn                = bgp.value.asn
      identifier_range   = bgp.value.identifier_range
      keepalive_interval = bgp.value.keepalive_interval
    }
  }

  dynamic "md5_authentication_keys" {
    for_each = each.value.md5_authentication_keys != null ? [each.value.md5_authentication_keys] : []
    content {
      key  = md5_authentication_keys.value.key
      name = md5_authentication_keys.value.name
    }
  }

  dynamic "params" {
    for_each = each.value.params != null ? [each.value.params] : []
    content {
      resource_manager_tags = params.value.resource_manager_tags
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

