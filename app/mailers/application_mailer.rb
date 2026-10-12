class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('MAILER_FROM', 'tasks@example.com')
  layout 'mailer'
end
