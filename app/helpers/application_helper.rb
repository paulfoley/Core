module ApplicationHelper
    
    def gravatar_small(email)
        gravatar_id = Digest::MD5::hexdigest(email).downcase
        "http://gravatar.com/avatar/#{gravatar_id}.png/?s=200"
    end
    
    def gravatar_large(email)
        gravatar_id = Digest::MD5::hexdigest(email).downcase
        "http://gravatar.com/avatar/#{gravatar_id}.png/?s=400"
    end
    
end
