class AuthenticationTokenService
    HMAC_SECRET = 'my$ecretK3y'
    ALGORITHM_TYPE = 'HS256'
    def self.call(user_id, user_role)
        hmac_secret = 'my$ecretK3y'
        payload = {user_id: user_id, user_role:user_role}
        token = JWT.encode payload, HMAC_SECRET, ALGORITHM_TYPE
    end

    def self.decode(token) 
        puts token
        decode_token = JWT.decode token, HMAC_SECRET, true, {algorithm: ALGORITHM_TYPE}
        if(decode_token)
            puts(decode_token)
            return decode_token[0]["user_id"]
        end
    rescue JWT::DecodeError
    end
end
