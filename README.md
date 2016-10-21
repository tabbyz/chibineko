# このリポジトリについて

このリポジトリは @ni3shi9p が個人的な勉強ため、兼 個人的な利用のために https://github.com/tabbyz/chibineko から fork し、カスタマイズしているものです。
以下の README は全て tabbyz/chibineko そのままを利用しています。
ライセンス等は元の tabbyz/chibineko に従います。

# Chibineko
[![CircleCI](https://circleci.com/gh/tabbyz/chibineko.svg?style=shield)](https://circleci.com/gh/tabbyz/chibineko)
[![License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)

**Chibineko** is a simple test supporting tool specializing in the management of manual tests.  
It is hosted on [https://chibineko.jp](https://chibineko.jp).


## Screenshot
### Top page
![screenshot_top](https://cloud.githubusercontent.com/assets/15026812/13838533/3930fb0a-ec58-11e5-87d2-07a22a808347.png)

### Execute a test
![screenshot_execute_test](https://cloud.githubusercontent.com/assets/15026812/13838537/3ac1d7fa-ec58-11e5-8d04-5e0a50cfb08e.png)

### Create a test
![screenshot_create_test](https://cloud.githubusercontent.com/assets/15026812/13838540/3cb37fd2-ec58-11e5-92b3-1aa43d3cb41e.png)


## Quick Start
### Install Chibineko on Heroku

Clone the repo

```console
$ git clone git@github.com:tabbyz/chibineko.git
$ cd chibineko
```

Create a app at Heroku

```console
$ heroku create NAME_FOR_YOUR_APP
```

Push an app to Heroku

```console
$ git push heroku master
```

Initialization of database

```console
$ heroku run rake db:migrate
$ heroku run rake db:seed
```

Set the environment variable

```console
$ heroku config:add SECRET_KEY_BASE=`rake secret`
```

Open your Chibineko and sign in with your credentials

```console
$ heroku open
```

Your username is `test@example.com` and your password is `test` as well.


### Configure Email

You must have email settings to the user registration.

Create a configuration file

```console
$ cp config/mailer.yml.example config/mailer.yml
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
$ git add .
$ git commit -m "Configure Email"
```

Push an app to Heroku

```console
$ git push heroku master
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
