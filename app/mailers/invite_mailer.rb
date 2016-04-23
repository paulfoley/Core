class InviteMailer < ApplicationMailer
    
    def invite_mail(email,org)
        @email = email
        @org_name = org
        mail(to: @email, subject: "Join CORE")
    end
    
end
