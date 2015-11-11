$get = {
  "/tmp/github": {
    "github_user" => "YourUserID",
    "local_user"  => "YourLocalUser",
    "token"       => "YourOauthHash",
  }
}

include github_projects
create_resources("github_projects::get", $get)

