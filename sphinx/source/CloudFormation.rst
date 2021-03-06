CloudFormation
==================================
* It is a declarative way of outlining your AWS infrastructure for any resources (most are supported) – Infrastructure as Code
* CloudFormation is a regional resource but it can create resources in any region
* For example, you can say
  
  * I want a security group
  * I want two EC2 instances using this security group
  * I want two elastic IPs for these EC2 machines
  * I want an S3 bucket
  * I want a load balancer in front of these EC2 machines

* CloudFormation creates these resources in the right order with the exact configuration that is specified
* There are three main components of Cloudformation
  
  * Template
  * Stacks
  * Change Sets


**Benefits of CloudFormation**

* Infrastructure as code
  
  * No resources are manually created
  * The code can be version controlled using git (for example)
  * Changes to the infrastructure are reviewed through code
  
* Cost
  * Each resource within the stack is stagged with an identifier so you can easily see how much a stack costs
  * You can estimate the cost of the resources using the CloudFormation template
  * Savings strategy: In dev, you could automate the deletion of all templates at 5 PM and recreate it at 8AM safely
* Productivity
  * Ability to destroy and re-create the cloud infrastructure on the fly
  * Automated generation of a diagram for your templates
  * Declarative programming (no need to figure out ordering and orchestration)
* Separation of concern
  
  * Create many stacks for many apps and layers
  * Example
  
    * VPC stacks
    * Network stacks
    * Application stacks
  
* Don’t’ re-invent the wheel
  * Leverage existing templates on the web
  * Leverage the documentation

**How does CloudFormation work?**

* Templates have to be uploaded to S3 and referenced in CloudFormation
* To update a template, we can’t edit previous ones. We have to re-upload a new version of the template to AWS
* Stacks are identified by a name
* Deleting a stack deletes every artifact that was created by CloudFormation

**Deploying CloudFormation Templates**

* Manual
  
  * Edit templates in the CloudFormation Designer
  * Use the console to input parameters
  
* Automated
  
  * Edit the templates in a YAML file
  * Use the AWS CLI to deploy the templates
  * This is the recommended way when the process needs to be fully automated

**CloudFormation Building Blocks**

* Template components

  * Resources
  
    * AWS Resources declared in the template

  * Parameters
  
    * The dynamic inputs to the template
  
  * Mappings
  
    * The static variables in the template
  
  * Outputs
  
    * References to what has been created
  
  * Conditionals
  
    * List of conditions like “If statements” to perform resource creation
  
  * Metadata

* Template Helpers
  
  * References
  
    * Link resources within the template

  * Functions
  
    * To transform data within the template 

**Creating a CloudFormation template**

* Choose a template and a stack (LAMP)
* Give the stack a name
* Specify the necessary parameters
  
  * DB User / DB Name and DB Password
  * Choose DB Instance type (t2.micro / t2.small)
  * Create stack
  
* Once a stack is created you can check on the events to see what was created or being created
* In the case of CloudFormation by default, if a resource failed during creation everything else is by default rolled back. This can however be changed

**Best Practices**

.. image:: _static/images/cloudformation/fig-1.png
  :align: center

 

