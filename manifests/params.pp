class github_projects::params {

  # Directory to install the gitim script
  $script_dir  = "/usr/local/bin"

  # filename of the gitim script
  $script_file = "gitim"

  # Do not perform a git pull every puppet run?
  $nopull      = true

  # How long to allow the gitim script to run (in seconds)
  $timeout     = 1200
}
