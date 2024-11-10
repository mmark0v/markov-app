# mmarkov-app

# Run the container 
git clone https://github.com/mmark0v/mmarkov-app.git
cd mmarkov-app
docker build  . -t mmark0v/mmarkov-app
docker run --name mmarkov-app -p 443:443 -p 80:80 -v $(pwd)/site/:/var/www/html/ mmark0v/mmarkov-app
