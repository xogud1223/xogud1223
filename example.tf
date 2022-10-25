resource "aws_security_group" "node" {
        
        
          
            name          = "allow_node_js_and_ssh"
        
        
          
            description   = "Allow SSH and nodejs port from all"
        
        
          
            ingress {
        
        
          
              cidr_blocks = ["0.0.0.0/0"]
        
        
          
              protocol    = "tcp"
        
        
          
              from_port   = 22
        
        
          
              to_port     = 22
        
        
          
            }
        
        
          
            ingress {
        
        
          
              cidr_blocks = ["0.0.0.0/0"]
        
        
          
              protocol    = "tcp"
        
        
          
              from_port   = 3000
        
        
          
              to_port     = 3000
        
        
          
            }
        
        
          
          }
        
        
          
          

        
        
          
          data "aws_security_group" "default" {
        
        
          
            name = "default"
        
        
          
          }
        
        
          
          

        
        
          
          resource "aws_instance" "example" {
        
        
          
              ami             = "ami-0e17ad9abf7e5c818"
        
        
          
              instance_type   = "t2.micro"
        
        
          
              key_name        = "keypair-seoul.pum"
        
        
          
          

        
        
          
              vpc_security_group_ids = [
        
        
          
                aws_security_group.node.id,
        
        
          
                data.aws_security_group.default.id
        
        
          
              ]
        
        
          
          

        
        
          
              provisioner "remote-exec" {
        
        
          
                connection {
        
        
          
                  user        = "ec2-user"
        
        
          
                  private_key = file("~/Downloads/keypair-seoul.pem")
        
        
          
                  host        = aws_instance.example.public_ip
        
        
          
                }
        
        
          
          

        
        
          
                inline = [
        
        
          
                  "sudo amazon-linux-extras install epel -y",
        
        
          
                  "sudo yum install --enablerepo=epel -y nodejs",
        
        
          
                  "sudo wget https://your.helloworld.js.link -O /home/ec2-user/helloworld.js",
        
        
          
                  "sudo wget https://your.helloworld.service.link -O /etc/systemd/system/helloworld.service",
        
        
          
                  "sudo systemctl enable helloworld",
        
        
          
                  "sudo systemctl start helloworld",
        
        
          
                ]
        
        
          
            }
        
        
          
          }
