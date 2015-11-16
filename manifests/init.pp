# github_projects
# ===============
# Install the gitim script and pygithub package
#
# Parameters
# ==========
# [*script_dir*]
#   Directory to install gitim script to
# [*nopull*]
#   Default setting for the nopull parameter
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
class github_projects(
    $script_dir = $github_projects::params::script_dir,
    $nopull     = $github_projects::params::nopull,
    $hour       = $github_projects::params::hour,
    $minute     = $github_projects::params::minute,
    $month      = $github_projects::params::month,
    $monthday   = $github_projects::params::monthday,
    $weekday    = $github_projects::params::weekday,

) inherits github_projects::params {
  
  $script_file = $github_projects::params::script_file

  File {
    owner => "root",
    group => "root",
    mode  => "0655",
  }

  file { "${script_dir}/${script_file}":
    ensure => file,
    source => "puppet:///modules/${module_name}/gitim/${script_file}",
    mode   => "0755",
  }

  package { "pygithub":
    ensure   => present,
    provider => "pip3",
  }
}
