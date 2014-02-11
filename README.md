IntergalacticTranslator
=======================

Description:

   This service is intended to compute the credits for the given transaction.

   Validations such as complying to roman language is done.  

   While computing credits, we take the standard measure from the configuration.

Input:

   Input consists of lines of text detailing the notes on the conversion 
   between intergalactic units and roman numerals. 

Response:

   Response object consists of the following,

   status   -  Indicates whether the operation is success or failure
   err-msg  -  If the operation is a failure, err_msg will contain 
               the reason for the failure
   object   -  If the operation is a failure, object will contain
               the details of the object which caused the failure.
   credits  -  If the operation is a success, credits will hold
               the details of the computed credits. 


Running the Application:

In the console try, "ruby TransactionClient.rb"

Sample Inputs and their response

	how much is pish tegj glob glob ?  
	Input : glob prok Iron
	Status : success
	Reason : Transaction Successful...
	glob prok Iron is 782.0 Credits
	================================================

	how much wood could a woodchuck chuck if a woodchuck could chuck wood ?
	Input : how much wood could a woodchuck chuck if a woodchuck could chuck wood
	Status : failure
	Reason : Unrecognized Language...
	================================================


