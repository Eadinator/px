variable "px" {
  type = object({
    provider = string
    repo     = string
    branch   = string
    domain   = string
  })
}
