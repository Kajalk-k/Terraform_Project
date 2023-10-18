#!/bin/bash
apt update
apt install -y apache2
apt-get install cloud-utils

# Get the instance ID using the instance metadata
INSTANCE_ID=$(ec2metadata --instance-id)

# Install the AWS CLI
apt install -y awscli

# Download the images from S3 bucket
#aws s3 cp s3://myterraformprojectbucket2023/project.webp /var/www/html/project.png --acl public-read

# Create a simple HTML file with the portfolio content and display the images
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
  <title>My Portfolio</title>
  <style>
    /* Add animation and styling for the text */
    @keyframes colorChange {
      0% { color: green; }
      50% { color: blue; }
      100% { color: red; }
    }
    h1 {
      animation: colorChange 2s infinite;
    }
  </style>
</head>
<body>
  <h1>Terraform Project </h1>
  <h2>Instance ID: <span style="color:green">$INSTANCE_ID</span></h2>
  <p>Welcome to First Kajal's First terrform Projects</p>
  
</body>
</html>
EOF


systemctl start apache2
systemctl enable apache2