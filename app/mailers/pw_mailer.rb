class PwMailer < ApplicationMailer
    
    def pw_mail(email)
        @email = email
        mail(to: @email, subject: "Test Email")
    end
end
