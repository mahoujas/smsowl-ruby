## Sms Owl Ruby Wrapper

This package is wrapper of Sms Owl REST API hosted at [https://smsowl.in](https://smsowl.in). Sms Owl provides transactional and promotional SMS Gateway services.

### Installing Sms Owl package

Use following command to install meteor package.

	$ gem install sms_owl

### Require the gem

Add requre statement where you like to use SmsOwl class.

	require "sms_owl"

### Configuring credentials

Credentials should be configured before sending SMS. Credential should be passed as constructor argument for SmsOwl constructor
	
	smsOwl = SmsOwl.new("YOUR-ACCOUNT-ID", "YOUR-API-KEY")


### Sending promotional SMS


##### sendPromotionalSms(senderId,to,message,smsType)

 - senderId: Sender Id registered and approved in Sms Owl portal.
 - to: Either single number with country code or list of phone numbers.
 - message: Message to be sent.
 - smsType: It can have either of two values `SmsOwl::SmsType::NORMAL` or `SmsOwl::SmsType::FLASH` (optional)
	
	
	
		begin
		   smsId = smsOwl.sendPromotionalSms("TESTER", "+9189876543210", "Hello Ruby", SmsOwl::SmsType::FLASH);
		   	//Process smsId if you need to
		rescue Exception => e
		    //Handle exception.
		end

Return value is Sms Id for single SMS and List of SMS ids for Bulk Sms


##### sendPromotionalSms(senderId,to,message)

Same as above but smsType defaults to `SmsOwl::SmsType::NORMAL`

### Sending Transactional SMS

##### sendTransactionalSms(senderId,to,templateId,placeholderArray);

 - senderId: Sender Id registered and approved in Sms Owl portal.
 - to: Destination number with country prefix. Only single number can be specified.
 - templateId: Template Id of message. Only template message can be send via transactional route.
 - placeholderArray: Placeholder values.

Lets assume templateId of `39ec9de0efa8a48cb6e60ee5` with following template.

	Hello {customerName}, your invoice amount is Rs. {amount}.

-


	begin
        smsId= smsOwl.sendTransactionalSms("TESTER", "+919876543210", "39ec9de0efa8a48cb6e60ee5",{ customerName: "Bob", amount: "200" });
        //Process smsid if needed.
    rescue Exception => e
        //Handle exception
    end


Return value is Sms Id.