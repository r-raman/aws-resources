CloudFront
==========
* It is a Content Delivery Network
* 216 edge locations
* Provides DDoS protection, integrates with Shield, AWS Web Application firewall
* Can expose HTTPS and can talk to internal backends via HTTPS
* Improves latency and reduces load to the S3 buckets
 
**CloudFront Origins**

* S3 Bucket  
* For distributing files and caching them at the edge
* Enhanced security with CloudFront – Origin Access Identity (OAI)
* OAI is an IAM role
* CloudFront can be used as Ingress (to upload files to S3)
* Custom Origin (HTTP)
  
  * Application Load Balancer
  * EC2 Instance
  * S3 Website
  * Any HTTP backend

**CloudFront at a High level**

.. image:: _static/images/cloudfront/fig-1.png
  :align: center

|

.. image:: _static/images/cloudfront/fig-2.png
  :align: center

|

.. image:: _static/images/cloudfront/fig-3.png
  :align: center

**CloudFront vs S3 Cross Region Replication**

* CloudFront:

  * Global Edge Network
  * Files are cached for a TTL (maybe a day)
  * Great for static content that must be available everywhere 

* S3 CRR:

  * Must be setup for each region you want replication to happen
  * Files are updated in near real-time 
  * Read Only
  * Great for dynamic content that needs to be available at low latency in few regions
 
In CloudFront you create a Distribution

A Distribution requires

* Origin Domain Name – for example S3 bucket ID
* Origin ID – for example S3 bucket ID
* Restrict Bucket Access – Yes
* Origin Access Identity (OAI)
  
  * Grant Read Permission to the identity

* Viewer Protocol Policy
  
  * Redirect HTTP to HTTPS
 
**CloudFront Caching**

* Cache can be based on
  
  * Headers
  * Session cookies
  * Query string parameters
  
* The cache lives at each CloudFront Edge Location
* You can control the TTL of the cache – Control header, Expires header
* You can invalidate part of the cache using the CreateInvalidation API
 
**Strategy for Static and Dynamic requests**

CloudFront Invalidating cache

* Go to a CF distribution and click on invalidations
 
**CloudFront Security**

Restrict who can access based on Geolocation

* Whitelist – Countries approved
* Blacklist – Countries banned
  
Restrict who can access based on HTTPS

* Viewer Protocol Policy

  * Redirect HTTP to HTTPS
  * Or use HTTPS only
  
* Origin Protocol Policy (HTTP or S3)
  
  * HTTP only
  * Or Match viewer
  
NOTE: S3 bucket websites does not support HTTPS
 
LOOK at Behavior for Viewer protocol policy
 
Geo Restrictions can be setup under CloudFront/Restritions
 
**CloudFront Signed URL / Cookies**

Use Case: To distribute paid shared content to premium users over the world

* Use CloudFront Signed URL / Cookie. We can attach a policy that includes
  
  * URL expiration
  * IP ranges to access the data from
  * Trusted signers – which AWS accounts can create a signed URLs
  
* How long should the URL should be valid for?
  
  * Shared content – short
  * Private content – long  
  
* Signed URL – gives access to a single file
* Signed Cookie – gives access to multiple files
 
 
**Signed URL process**

Go to CloudFront / Key Management 
Two types of signers

* Trusted Key Group (recommended)
  
  * Can leverage APIs to create and rotate keys (and IAM for API security)
  
* An AWS account that contains a CloudFront Key Pair
  
  * Need to manage keys using the root user and the AWS console
  * Not recommended
  * Cannot automate
  
* In the CF distribution create one or more Trusted Key Group
* Generate a Public and Private Key – CloudFront / Key Management
  
  * The private key is used by EC2 instances to sign URLs
  * The public key used by CF is uploaded to CloudFront to verify URLs
 
**CloudFront Signed URL vs S3 Signed URL**

* CloudFront
  
  * Allow access to a path, no matter the origin
  * Account wide key-pair – only the root can manage it
  * Can filter by IP, path, date, expiration
  * Can leverage caching capabilities
  
* S3
  
  * Issue a request as the person who pre-signed the URL
  
* Uses the IAM key of the signing IAM principal

  * Limited lifetime
  
CloudFront Signed URL are commonly used to distribute paid content through dynamic CloudFront Signed URL generation
 
**CloudFront Price Classes**

* Price Class All: all regions – best performance
* Price Class 200: most regions, but excludes the most expensive regions
* Price Class 100: Only the least expensive regions
 
 
**CloudFront – Multiple Origin**

* To route to different kind of origins based on the content type
* Based on path pattern
  
  * /images/*
  * /api/*
  * /*
 
**CloudFront – Origin Groups**

* To increase high availability and do failover
* Origin group: One primary and one secondary
* Applicable to both EC2 and S3
 
 
 
 
**CloudFront – Field Level Encryption**

* Protect user sensitive information through application stack
* Adds an additional layer of security along with HTTPS
* Sensitive information encrypted at the edge close to the user
* Uses asymmetric encryption
* Usage:
  
  * Specify a set of fields in POST requests that you want to be encrypted – up to 10 fields
  
* Example, credit card info
  
  * Specify the public key to encrypt them
 
 

