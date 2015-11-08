define github_projects::get(
  $github_user,
  $local_user,
  $base_dir = $title,
  $script_dir = $github_projects::script_dir,
  $script_file = $github_projects::script_file,
  $nopull = $github_projects::nopull,
) {

  $script = "${script_dir}/${script_file}"
  $_nopull = $nopull ? {
    true  => "--nopull",
    false => "",
  }

  # Run this every puppet run to fetch any new projects
  exec { "github_projects__get_${title}":
    command => "${script} -u ${github_user} ${nopull} --dest ${base_dir}",
    user    => $local_user,
    path    => [
        "/bin",
        "/usr/bin",
    ],
    require => Package["pygithub"],
  }
}
