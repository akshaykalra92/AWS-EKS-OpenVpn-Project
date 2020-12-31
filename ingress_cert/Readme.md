If you want to run ingress with domain name and certificate instead using ALB URL. Replace this file with ingrees.tf

It will create route53 domain service and register your service with AWS certificate manager.
Note: Amazon will validate your domain name/certificate request so you will get the email from amazon to approve the request. 
Terraform will fail until you accept that request. sometime it will take a day.
I strong suggest you can create domain/certificate earlier using terrform/manual and here you just call that domain using terraform data in line 2.

Terraform will be failed for first time. Approve amazone request and run again.