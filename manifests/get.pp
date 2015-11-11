# github_projects::get
# ====================
# Use the GitHub API via the gitim script to clone repositories for a given
# GitHub user into a specified directory.
#
# Parameters
# ==========
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
# [*timeout*]
#   How long to allow the gitim script to run in seconds.  Pass zero to disable
#   timeouts
# [*token*]
#   OAuth token to use for accessing the GitHub API
# [*password*]
#   Password to use for accessing the GitHub API
define github_projects::get(
  $github_user,
  $local_user,
  $base_dir    = $title,
  $script_dir  = $github_projects::script_dir,
  $script_file = $github_projects::script_file,
  $nopull      = $github_projects::nopull,
  $timeout     = $github_projects::timeout,
  $token       = false,
  $password    = false,
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
  exec { "github_projects__get_${title}":
    command => "${script} -u ${github_user} ${_nopull} --dest ${base_dir} ${auth}",
    user    => $local_user,
    path    => [
        "/bin",
        "/usr/bin",
    ],
    timeout => $timeout,
    require => Package["pygithub"],
  }
}
