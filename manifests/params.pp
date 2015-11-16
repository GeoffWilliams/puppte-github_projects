class github_projects::params {

  # Directory to install the gitim script
  $script_dir   = "/usr/local/bin"

  # filename of the gitim script
  $script_file  = "gitim"

  # Do not perform a git pull every puppet run?
  $nopull       = true

  # run every 2 hours
  $hour         = "*/2"

  # customised offset per host
  $minute       = fqdn_rand(59)

  # run every month
  $month        = "*"

  # run every day of the month
  $monthday     = "*"

  # run every weekday
  $weekday      = "*"
}
