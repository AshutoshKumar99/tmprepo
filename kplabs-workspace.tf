#Configure aws provider
provider "aws" {
    region = "ap-south-1" #Resource will be created for this region
    access_key = "AKIA6IFD7ZT7J5JRXIIB"   #terraform will authnticate using these keys(Static credentials)
    secret_key ="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"
}


resource "aws_instance" "terraform-firstEc2" {  #aws_instance- I want to create a resource based on aws_instance, terraform-firstEc2 whatever name,terraform-firstEc2 is the local resource name
    ami = "ami-04db49c0fb2215364"   # ami and instance_type are attributes
    #Depending upon the workspace,instance_type needs to be changed.
    instance_type = lookup(var.instance_type,terraform.workspace) #using lookup function, terraform.workspace is the name of the current workspace
    #lookup(map, key, default), map here is var.instance_type and key is value which will come from terraform.workspace. terraform.workspace will show you the workspace you are curretly in and based on that the appropriate value within the map will be shown .Default value is optional
}

#now we want following-
# If we have default workspace, we want out instance_type to be t2.nano
# If we have dev workspace, we want out instance_type to be t2.micro
# If we have prd workspace, we want out instance_type to be t2.large

#Creating map function

variable "instance_type" {
    type = map(string)

    default = {
        default = "t2.nano" #For default workspace
        dev = "t2.micro" #For dev dev
        prd = "t2.large" #For prd prd
    }
  
}