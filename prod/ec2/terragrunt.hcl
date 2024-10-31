

terraform {
  # Deploy version v0.0.1 in prod
  source = "https://github.com/kundathilnithi/tform-infra-modules.git//modules/app-instance?ref=main"
}

inputs = {
  instance_count = 2
  type = "t2.micro"
}