class PwMailer < ApplicationMailer
    default from: "corecloudappmailer@gmail.com"
    
    def pw_mail(email)
        @email = email
        puts @email
        mail(to: @email, subject: "Test Email")
    end
end
