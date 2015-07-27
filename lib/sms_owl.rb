require 'net/http'
require 'json'

ENV['SSL_CERT_FILE'] =  File.dirname(__FILE__) + '/cacert.pem'

class SmsOwl

	class SmsType
		NORMAL = "normal"
		FLASH = "flash"
	end


	URL = URI('https://api.smsowl.in/v1/sms');

	def initialize(accountId,apiKey)
		@accountId = accountId
		@apiKey = apiKey
	end

	def sendPromotionalSms(senderId,to,message,smsType = SmsOwl::SmsType::NORMAL)
		req = Net::HTTP::Post.new(SmsOwl::URL, initheader = {'Content-Type' =>'application/json'})
		data = getCommonArray("promotional",smsType,senderId,to)
		data['message'] = message
		req.body = data.to_json
		res = Net::HTTP.start(URL.hostname, URL.port,
			:use_ssl => URL.scheme == 'https') do |http|
			http.request(req)
		end
		if res.code == '200'
			jsonRes = JSON.parse(res.body)
			if to.kind_of?(Array)
				return jsonRes["smsIds"]
			else
				return jsonRes["smsId"]
			end
		elsif res.code == '400'
			jsonRes = JSON.parse(res.body)
			raise jsonRes['message']
		end
	end

	def sendTransactionalSms(senderId,to,templateId,placeholderArray)
		req = Net::HTTP::Post.new(SmsOwl::URL, initheader = {'Content-Type' =>'application/json'})
		data = getCommonArray("transactional","normal",senderId,to)
		data['templateId'] = templateId
		data['placeholders'] = placeholderArray
		req.body = data.to_json
		res = Net::HTTP.start(URL.hostname, URL.port,
			:use_ssl => URL.scheme == 'https') do |http|
			http.request(req)
		end
		if res.code == '200'
			jsonRes = JSON.parse(res.body)
			return jsonRes["smsId"]
		elsif res.code == '400'
			jsonRes = JSON.parse(res.body)
			raise jsonRes['message']
		end
	end


	def getCommonArray(dndType,smsType,senderId,to)
		return {   	
    		accountId: @accountId,
	    	apiKey: @apiKey,
	    	dndType: dndType,
	    	smsType: smsType,
	    	senderId: senderId,
	    	to: to
	    }
	end
end