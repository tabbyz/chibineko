# Chibineko

## Overview
Chibineko is the simplest test supporting tool.


## Hosting Service
[https://chibineko.jp](https://chibineko.jp)


## Quick Start
### Install Chibineko on Heroku

Clone the repo

```console
git clone git@github.com:tabbyz/chibineko.git
cd chibineko
```

Create a app at Heroku

```console
heroku create NAME_FOR_YOUR_APP
```

Push an app to Heroku

```console
git push heroku master
```

Initialization of database

```console
heroku run rake db:migrate
heroku run rake db:seed
```

Set the environment variable

```console
heroku config:add SECRET_KEY_BASE=`rake secret`
```

Open your Chibineko and sign in with your credentials

```console
heroku open
```

Your username is `test@example.com` and your password is `test` as well.


### Configure Email

You must have email settings to the user registration.

Create a configuration file

```console
cp config/mailer.yml.example config/mailer.yml
```

```yaml
# For example, if you want to use Gmail as the SMTP server.

production:
  default_url_options:
    host: "example.com"
  delivery_method: :smtp
  smtp_settings:
    enable_starttls_auto: true
    address: "smtp.gmail.com"
    port: 587
    domain: "example.com"
    authentication: "plain"
    user_name: "<yourname>@gmail.com"
    password: "<yourpassword>"
```

Remove it from `.gitignore`

```yaml
config/mailer.yml  # Remove
```

To commit the changes

```console
git add .
git commit -m "Configure Email"
```

Push an app to Heroku

```console
git push heroku master
```


## Contributing
1. Fork it
1. Create your feature branch (`git checkout -b my-new-feature`)
1. Commit your changes (`git commit -am 'Add some feature'`)
1. Push to the branch (`git push origin my-new-feature`)
1. Create new Pull Request


## License
See [LICENSE](LICENSE).
© SHIFT, Inc. All Rights Reserved.