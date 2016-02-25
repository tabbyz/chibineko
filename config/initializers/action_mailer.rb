unless Chibineko::Application.config.action_mailer.nil?
  if options = YAML.load_file(Rails.root.join("config", "mailer.yml"))[Rails.env]
    Chibineko::Application.config.action_mailer.merge! options.deep_symbolize_keys!
  end
end