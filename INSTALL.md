# zarCars

# Run the container 
git clone https://github.com/mmark0v/zarCars.git
cd zarCars
docker build  . -t mmark0v/zarcars
docker run --name zarcars -p 443:443 -p 80:80 -v $(pwd)/site/:/var/www/html/ -v letsencrypt:/etc/letsencrypt/ mmark0v/zarcars
