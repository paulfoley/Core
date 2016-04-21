class InviteMailer < ApplicationMailer
    
    def invite_mail(email)
        @email = email
        mail(to: @email, subject: "Join CORE")
    end
    
end
