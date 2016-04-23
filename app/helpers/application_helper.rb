module ApplicationHelper
    
    def gravatar_small(user)
        gravatar_id = Digest::MD5::hexdigest(user.email).downcase
        "http://gravatar.com/avatar/#{gravatar_id}.png/?s=200"
    end
    
    def gravatar_large(user)
        gravatar_id = Digest::MD5::hexdigest(user.email).downcase
        "http://gravatar.com/avatar/#{gravatar_id}.png/?s=400"
    end
    
end
