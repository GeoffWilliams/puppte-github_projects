# github_projects::get
# ====================
# Use the GitHub API via the gitim script to clone repositories for a given
# GitHub user into a specified directory.
#
# Parameters
# ==========
# [*ensure*]
#   basic state this resource should be in. `present` or `absent`
# [*github_user*]
#   User ID of GitHub account to clone from
# [*local_user*]
#   Local unix account to checkout to.  This will be the owner of the gitim
#   process when it is run
# [*base_dir*]
#   Directory to checkout repositories under.  Defaults to $title
# [*script_dir*]
#   Path to gitim script
# [*script_file*]
#   Name of the gitim executable
# [*nopull*]
#   Set false to automatically do a git pull on every project on each puppet
#   run, otherwise do not attempt to update repositories automatically
# [*token*]
#   OAuth token to use for accessing the GitHub API
# [*password*]
#   Password to use for accessing the GitHub API
# [*hour*]
#   default value for corresponding cron parameter
# [*minute*]
#   default value for corresponding cron parameter
# [*month*]
#   default value for corresponding cron parameter
# [*monthday*]
#   default value for corresponding cron parameter
# [*weekday*]
#   default value for corresponding cron parameter
define github_projects::get(
  $github_user,
  $local_user,
  $ensure       = present,
  $base_dir     = $title,
  $script_dir   = $github_projects::script_dir,
  $script_file  = $github_projects::script_file,
  $nopull       = $github_projects::nopull,
  $token        = false,
  $password     = false,
  $hour         = $github_projects::hour,
  $minute       = $github_projects::minute,
  $month        = $github_projects::month,
  $monthday     = $github_projects::monthday,
  $weekday      = $github_projects::weekday,
) {

  $script = "${script_dir}/${script_file}"
  $_nopull = $nopull ? {
    true  => "--nopull",
    false => "",
  }

  if $token {
    $auth = "--token ${token}"
  } elsif $password {
    $auth = "--password ${password}"
  } else {
    fail("${module_name}::get { ${title}:} requires one of token or password to be set")
  }

  # Run this every puppet run to fetch any new projects
  cron { "github_projects__get_${title}":
    ensure      => $ensure,
    command     => "${script} -u ${github_user} ${_nopull} --dest ${base_dir} ${auth}",
    user        => $local_user,
    environment => "PATH=/usr/bin:/bin",
    require     => Package["pygithub"],
    hour        => $hour,
    minute      => $minute,
    month       => $month,
    monthday    => $monthday,
    weekday     => $weekday,
  }
}
