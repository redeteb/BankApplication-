The PURPOSE of this Workload
--------------------------------------------
    
    
- The purpose of Deployment Workload 2 was to automate the deployment of an application to AWS Elastic Beanstalk using a CI/CD pipeline, Jenkins. This process removes manual steps, ensuring consistent and reliable deployments. 

The STEPS taken 
----

- After cloning the neccesary applicaiton files repo, I generated new Access Keys under my username in IAM. 

- Note: I made sure to save these immediately because they can only be viewed once on the AWS Management console. And they especially need to be stored safely, and never shared,  because they grant full access to your AWS resources. If someone else gets hold of these keys, they can impersonate you, access your services, and potentially cause significant damage.

- I saved the keys in my local machine’s Environment Variables.
[Win +x, Advanced System Settings, Environment Variables, Add 2 New]

- I created an EC2 instance to serve as my Jenkins Server. I made sure to properly configure the security groups, key pairs, ports, and application install. 

- Within the Jenkins Server I created a script  called "system_resources_test.sh" that checks for system memory, cpu and disk and throws out an error code if the resource exceeds a threshold of 60%.

- Note: Exit codes are crucial because they signal whether a script has executed successfully or encountered an error. In a CI/CD pipeline, exit codes determine the flow of the pipeline. A non-zero exit code will automatically stop the pipeline. This ensures that only stable code progresses through the pipeline. 

- After logging into [MyPublicIP]:8080 I created my first Admin User in Jenkins. I then connected my GitHub repo to a Multi-Branch Pipeline

INSERT IMAGE 2 HERE

- I then Installed AWS CLI on the Jenkins Server and verified by checking the version number.

- Note: After becoming the user “jenkins”, I then activated the Python Virtual Environment. A Python virtual environment is an isolated environment that allows you to manage dependencies for a specific project without affecting the system-wide Python installation. This is important because it ensures each project has its own set of dependencies.

- I then installed the AWS EB CLI to my server. And after adding a "deploy" stage to the Jenkinsfile, by using this CLI I was very easily able to give the requirements for my EB environment to be deployed through the Jenkins Console.

- Unfortunately the pipeline failed at the Deploy Stage and after looking at the Console Output I was able to determine it failed due to system_resources_test.sh reporting there were errors codes triggered during the Build Stage. 

INSERT PHOTO 4 HERE

- After editing the script to have a 90% threshold insteasd of a 60% threshold, I rebuilt the pipeline and it still failed. But this time it failed differently. It didnt get to the second stage, Build, and stayed "In Progress" for over 12 hours. 

- After further investigation in the Console Output and research into the error messages shown I figured out the problem was a Node being offline. Nodes must be online and available to execute the jobs as they provide the necessary computing power and environment for the build process. Without an active node, the pipeline has nowhere to run, and therefore, it cannot proceed, resulting in a failure.

INSERT IMAGE 8 

- Attempts to turn the Node on were not being processsed by Jenkins and kept turning back off. More troubleshooting led to the discovery that there wasn't enough Disk Space left on the Jenkins Server to supprt the Node due to all the previous failed builds still being saved on there. After deleting the failed pipleines and checking the new amount of  Disk Space, I reran the the Pipeline and it was successful.  

INSSERT 9 AND 7


INSERT SYSTEM DESIGN DIAGRAM



e. An "OPTIMIZATION" section for that answers the question: How is using a deploy stage in the CICD pipeline able to increase efficiency of the buisiness? What issues, if any, can you think of that might come with automating source code to a production environment? How would you address/resolve this?

f. A "CONCLUSION" statement as well as any other sections you feel like you want to include.





