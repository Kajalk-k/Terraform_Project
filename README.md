# Terraform Project to deploy infrastructre components

This project demonstrates how to deploy a infrastructure components using terraform in AWS.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Monitoring](#Automation-of-Infrstructure-as-code-deployment)
- [Contributing](#contributing)
- [The output of application](#Screenshots-of-the-Process)

## Prerequisites

Before you begin, ensure you have the following prerequisites:

- **Terraform Installed**: Install terraform in your local 
- **AWS CLI**: Configure AWS CLI for authentication.


## Getting Started

Follow these steps to get started with this project:

1. Clone this repository:

   ```bash
   git clone https://github.com/Kajalk-k/Terraform_Project
   cd Terrform_Project
   ```

2. Configure the AWS :
    ```bash
     aws configure
     (Enter the Access id)
     
3. Initialise the Terraform

   ```bash
   terraform plan.
   ```

4. Validate the code and format it:
  
  ```bash
   terraform validate
    terraform fmt
   ```


5. Do Terraform plan to check the resources that are going to be created :

    ```bash
   terraform plan.
   ```


6. Apply the code using:

    ```bash
   terraform apply -auto-approve.
   ```


## Project Structure

The project structure is organized as follows:

```
Terraform_Project/
├── main.tf
├── provider.tf
├── variables.tf
├── web1.sh
├── web2.sh
├── web3.sh
```

- `main.tf`: Contains declaration for actual resources to be created.
- `provider.tf`: Contains the provider details where the resources will be created. 
- `variables.tf`: Contains the variables details.
- `web1.sh`, `web2.sh` and `web3.sh`: Script to be run just during the initialisation of EC2 instances that are created by terraform.
- `README.md`: This file, providing project documentation.


## Automation of Infrstructure as code deployment

You can automate the deployment of infrastructure using terraform code . Ensure you have the necessary tools and configurations .

## Contributing

Feel free to contribute to this project by opening issues or creating pull requests. Your contributions are welcome!

## Screenshots of the Process

![image](https://github.com/Kajalk-k/Terraform_Project/assets/17482074/4dcdc4f7-876f-4f3e-a487-41093a48949c)

![image](https://github.com/Kajalk-k/Terraform_Project/assets/17482074/68c28ac9-844c-4f2c-af6b-9fb1eef76a21)

![image](https://github.com/Kajalk-k/Terraform_Project/assets/17482074/81cbd49f-b73e-41b8-adc4-1b26cad80ee5)

![image](https://github.com/Kajalk-k/Terraform_Project/assets/17482074/b1482c76-1dc7-45d4-b145-d3f385af55b9)

![image](https://github.com/Kajalk-k/Terraform_Project/assets/17482074/df730673-d00e-46b8-84de-c2916ae3c3e4)









Remember to replace placeholders like `your-monitoring-app`, `yourusername`, `your-region`, `your-account-id`, and adjust the content as per your actual project details and preferences. This `README.md` provides a starting point for documenting your project's deployment process on Amazon EKS for a Flask-based monitoring application.
