The PURPOSE of this Workload
--------------------------------------------
    
    
- The purpose of this Deployment Workload was to automate the deployment of an application to AWS Elastic Beanstalk using a Jenkins CI/CD pipeline. This process removes manual steps, ensuring consistent and reliable deployments. 

The STEPS taken 
----

- After cloning the necessary applicaiton files repo, I generated new Access Keys under my username in IAM. 

- Note: I made sure to save these immediately because they can only be viewed once on the AWS Management console. They especially need to be stored safely and never shared, because they grant full access to your AWS resources. If someone else gets hold of these keys, they can impersonate you, access your services, and potentially cause significant damage.

- I saved the keys in my local machine’s Environment Variables.
[Win +x, Advanced System Settings, Environment Variables, Add 2 New]

- I launched an EC2 instance to serve as my Jenkins Server. I made sure to properly configure the security groups, key pairs, ports, and application install. 

- Within the Jenkins Server I ran the script named "system_resources_test.sh" that checks for system memory, cpu and disk and throws out an error code if the resource exceeds a threshold of 60%.

- Note: Exit codes are important because they signal whether a script has executed successfully or encountered an error. In a CI/CD pipeline, exit codes determine the flow of the pipeline. A non-zero exit code will automatically stop the pipeline. This ensures that only stable code progresses through the pipeline. 

- After logging into [MyPublicIP]:8080 I created my first Admin User in Jenkins. I then connected this repo to a Multi-Branch Pipeline.


![2](https://github.com/user-attachments/assets/867b26c8-7e59-4a76-9a74-30a7af543f8e)


- I then Installed AWS CLI on the Jenkins Server and verified by checking the version number.

- Note: After becoming the user “jenkins”, I then activated the Python Virtual Environment. A Python virtual environment is an isolated environment that allows you to manage dependencies for a specific project without affecting the system-wide Python installation. This is important because it ensures each project has its own set of dependencies.

- I then installed the AWS EB CLI to my server. And after adding a Deploy Stage Module to the Jenkinsfile, by using the CLI I was very easily able to give the requirements for my EB environment to be deployed through the Jenkins Console within a couple commands which makes it very efficient. 

- Unfortunately the pipeline failed at the Deploy Stage and after looking at the Console Output I was able to determine it failed due to system_resources_test.sh reporting there was an error code triggered during the Build Stage. 

![4](https://github.com/user-attachments/assets/75224484-bc02-4200-a5bc-195f9b150004)

- After editing the script to have a 90% threshold insteasd of a 60% threshold, I rebuilt the pipeline and it still failed. But this time it failed differently. It didnt get to the second stage, Build, and stayed "In Progress" for over 12 hours. 

- After further investigation in the Console Output and research into the error messages shown I figured out the problem was a Node being offline. Nodes must be online and available to execute the jobs as they provide the necessary computing power and environment for the build process. Without an active node, the pipeline has nowhere to run, and therefore, it cannot proceed, resulting in a failure.

![8](https://github.com/user-attachments/assets/4a32e8ca-8e8a-4873-8f11-58fb606dcd75)


- Attempts to turn the Node on within the Jenkins Console were not working and it kept turning itself back off. More troubleshooting led to the discovery that there wasn't enough Disk Space left on the EC2 Instance supporting Jenkins to support the Node due to all the previous failed builds (8) still being saved on there. After deleting the failed pipelines and checking the new amount of Disk Space, I rebuilt the Pipeline and it was successful.  

![9](https://github.com/user-attachments/assets/6cc5c343-dca2-4558-b5c3-21020b375c66)
![7](https://github.com/user-attachments/assets/6fa8640b-d39a-42b9-b006-5e1d1da41aff)



![Workload2 drawio](https://github.com/user-attachments/assets/5ceb2d8c-85c3-405f-aea1-f71bd0b4c8c9)




Optimization 
-------
Incorporating a deploy stage in the CI/CD pipeline boosts business efficiency by automating deployments, ensuring that new features, bug fixes, and updates reach production consistently, reducing time to market and minimizing human error. However, without proper version control or rollback systems in place, automated deployments can risk overwriting stable versions, potentially causing crashes. To avoid this, it's crucial that teams and individuals follow best practices in version control, always enabling a return to a previous stable version when needed.

Conclusion
----
This workload demonstrated the importance of automation in the deployment process, highlighting the need for proper troubleshooting and resource management. 
