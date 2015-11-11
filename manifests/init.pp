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
# [*timeout*]
#   Default maximum time for the gitim script to run (in seconds)
class github_projects(
    $script_dir = $github_projects::params::script_dir,
    $nopull     = $github_projects::params::nopull,
    $timeout    = $github_projects::params::timeout,
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
