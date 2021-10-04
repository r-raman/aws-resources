AWS CLI
=========
.. code-block:: bash

    aws configure 
    # In the EC2 instance you can
    cat config
    cat credentials
 
If you are the use profiles you need to specify the --profile <PROFILE_NAME> while running the commands
aws s3 ls --profile <PROFILE_NAME>
 
MFA with CLI
------------
The MFA is set under UAM/User/Security credentials tab
Once the MFA is setup, we can get the arn of the MFA device
 
  #. To use MFA with the CLI, you must create a temporary session
  #. To create a temporary session use the STS GetSessionToken API call

.. code-block:: bash

    aws sts get-session-token --serial-number arn-of-the-mfa-device --token-code code-from-token --duration-seconds 3600
 
.. image:: _static/images/aws-cli/fig-1.png
    :align: center

Once you ger the MFA configured you can create an MFA profile

.. code-block:: bash

    aws configure --profile mfa

You can input the values above in following prompt
Then 

.. code-block:: bash

    cat ~/.aws/credentials

You should copy the token into the credentials
 
AWS SDK
While using the SDK, if a region is not specified, then us-east-1 will be used as default
 

AWS Limits
-----------

**API Rate limits**
  #. DescribeInstances API for EC2 has a limit of 100 calls per second
  #. GetObject on S3 has a limit of 5500 GETs per second per prefix
  #. For Intermittent Errors – implement Exponential Backoff
  #. For Consistent Errors – request an API throttling limit increase
 
**Service Quotas (formerly Service limits)**
  #. Running on demand standard instances: 1152 vCPU
  #. For more vCPU, request a service limit increase by opening a ticket
  #. For service quota increase, use the service quota API
 
**Exponential Backoffs**
  #. They are used for avoiding intermittent errors
  #. When you get a throttling exceptions, use exponential backoff
  #. Must only retry 5xx errors
 
AWS CLI Credentials Provider Chain
-----------------------------------

https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html#config-settings-and-precedence
 
**The CLI will look for credentials in this order**
  #. Command line options – --region, --output and --profile.
  #. Environment Variables – AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AND AWS_SESSION_TOKEN.
  #. CLI credentials file – aws configure ~/.aws/credentials.
  #. CLI configuration file – aws configure ~/.aws/config.
  #. Container credentials – for ECS tasks.
  #. Instance profile credentials – for EC2 instance profile.
 
**For Java SDK (for example) will look for credentials in this order**
  #. Java system properties – aws.accessKeyId and aws.secretKey
  #. Environment variables – AWS_ACCESS_KEY_ID AND AWS_SECRET_ACCESS_KEY
  #. The default system profile files – at ~/.aws/credentials
  #. Amazon ECS container credentials – for ECS containers
  #. Instance profile credentials – for EC2 instance profile
 
**For with within AWS, use IAM roles**
  #. EC2 instance roles for EC2 instances
  #. ECS roles for ECS tasks
  #. Lambda roles for Lambda functions


**If working outside of AWS**
  #. Use environment variables or named profiles
 

**AWS Signing – CLI and the SDK**
  #. When you call the AWS HTTP API, you sign the request so that AWS can identify you, using your AWS credentials (access key and secret key) ``Note: Some of the API request to S3 do NOT need to be signed``
  #. If you use the SDK or the CLI, all the HTTP requests are signed for you
  #. If you are not using the SDK or the CLI to contact AWS, you should sign the HTTP request using Signature v4 (Sig v4)

.. image:: _static/images/aws-cli/fig-2.png
    :align: center
 
**Sig v4:**
  #. Sign the request using the HTTP header
  #. Authrorization header
  #. The other option is to use the query string – S3 pre-signed URL
   
    * x-amz-algorithm
    * x-amz-credential
    * x-amz-date
    * x-amz-signature
    
When running the CLI on EC2 Instances, the CLI uses the ___meta___ service to get __temporary___ credentials thanks to the IAM Role that is attached. 
 
**I want to test whether my EC2 machine is able to perform the termination of EC2 instances. There is an IAM role attached to my EC2 Instance. I should**

Use the IAM policy simulator OR the dry run CLI option
 
**You can use the policy simulator to compare two IAM roles (get it from EC2 meta-data)**

You can retrieve the role name attached to your EC2 instance using the metadata service but not the policy itself

