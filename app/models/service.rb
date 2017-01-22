class Service < ApplicationRecord
  has_many :hooks

  def deploy
    apps_path = Rails.application.config.apps_path
    command = <<-EOS
      cd #{apps_path}/#{app_name};
      docker-compose pull #{name};
      docker-compose stop #{name};
      docker-compose rm -f #{name};
      docker-compose create #{name};
      docker-compose start #{name};
    EOS

    puts "doing:\n #{command}"
    system command
  end

  def start
    apps_path = Rails.application.config.apps_path
    command = <<-EOS
      cd #{apps_path}/#{app_name};
      docker-compose start #{name};
    EOS

    system command
  end

  def stop
    apps_path = Rails.application.config.apps_path
    command = <<-EOS
      cd #{apps_path}/#{app_name};
      docker-compose stop #{name};
    EOS

    system command
  end

  def logs(tail = 100)
    apps_path = Rails.application.config.apps_path
    command = <<-EOS
      cd #{apps_path}/#{app_name};
      docker-compose logs --tail #{tail.to_i} #{name};
    EOS

    `#{command}`
  end
end
