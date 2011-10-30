# lots of stuff taken from https://github.com/intridea/omniauth/blob/0-3-stable/oa-oauth/lib/omniauth/strategies/oauth2/taobao.rb
require 'omniauth-oauth2'
module OmniAuth
  module Strategies
    class Taobao < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :authorize_url => 'https://oauth.taobao.com/authorize',
        :token_url => 'https://oauth.taobao.com/token',
      }
      def request_phase
        options[:state] ||= '1'
        super
      end


      uid { raw_info['uid'] }

      info do
        {
          'uid' => raw_info['uid'],
          'user_info' => raw_info,
          'extra' => {
            'user_hash' => raw_info,
          },
        }
      end

      def raw_info
        url = 'http://gw.api.taobao.com/router/rest'

        query_param = {
          :app_key => client_id,

          # TODO to be moved in options
          # TODO add more default fields (http://my.open.taobao.com/apidoc/index.htm#categoryId:1-dataStructId:3)
          :fields => 'user_id,uid,nick,sex,buyer_credit,seller_credit,location,created,last_visit,birthday,type,status,alipay_no,alipay_account,alipay_account,email,consumer_protection,alipay_bind',
          :format => 'json',
          :method => 'taobao.user.get',
          :session => @access_token.token,
          :sign_method => 'md5',
          :timestamp   => Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          :v => '2.0'
        }
        query_param = generate_sign(query_param)
        res = Net::HTTP.post_form(URI.parse(url), query_param)
        @raw_info ||= MultiJson.decode(res.body)['user_get_response']['user']
      rescue ::Errno::ETIMEDOUT
        raise ::Timeout::Error
      end
      
      def generate_sign(params)
        # params.sort.collect { |k, v| "#{k}#{v}" }
        str = client_secret + params.sort {|a,b| "#{a[0]}"<=>"#{b[0]}"}.flatten.join + client_secret
        params['sign'] = Digest::MD5.hexdigest(str).upcase!
        params
      end
    end
  end
end