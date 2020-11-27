### To build docker image use command -

```sh
sudo docker build -t postresql-node:12.5 .
```


### To run the image created use command -

```sh
sudo docker run -p 5432:5432 -p 7000:7000 --name prostgres -e POSTGRES_PASSWORD=RaNd0MpA55W0Rd  postresql-node:12.5
```

It will create a new db called "postgres", with user "postgres" and set root password of "RaNd0MpA55W0Rd".