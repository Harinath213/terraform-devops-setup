data "aws_ami" "basic-app" {
    most_recent = true
    owners = [661279040337]
    filter {
      name = "image-id"
      values = ["ami-0f09af54be678dbb1"]
    }
  
}

resource "aws_instance" "web-server" {
    ami       = data.aws_ami.basic-app.id
    instance_type = "t2.micro"

    tags = {
        name = "web-server"
    }

  
}