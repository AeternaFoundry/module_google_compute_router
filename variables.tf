variable "compute_routers" {
  description = <<EOT
Map of compute_routers, attributes below
Required:
    - name
Optional:
    - deletion_policy
    - description
    - encrypted_interconnect_router
    - ncc_gateway
    - network
    - project
    - region
    - bgp (block):
        - advertise_mode (optional)
        - advertised_groups (optional)
        - advertised_ip_ranges (optional, block):
            - description (optional)
            - range (required)
        - asn (required)
        - identifier_range (optional)
        - keepalive_interval (optional)
    - md5_authentication_keys (block):
        - key (required)
        - name (required)
    - params (block):
        - resource_manager_tags (optional)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    name                          = string
    deletion_policy               = optional(string)
    description                   = optional(string)
    encrypted_interconnect_router = optional(bool)
    ncc_gateway                   = optional(string)
    network                       = optional(string)
    project                       = optional(string)
    region                        = optional(string)
    bgp = optional(object({
      advertise_mode    = optional(string)
      advertised_groups = optional(list(string))
      advertised_ip_ranges = optional(list(object({
        description = optional(string)
        range       = string
      })))
      asn                = number
      identifier_range   = optional(string)
      keepalive_interval = optional(number)
    }))
    md5_authentication_keys = optional(object({
      key  = string
      name = string
    }))
    params = optional(object({
      resource_manager_tags = optional(map(string))
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  # Note: 3 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

