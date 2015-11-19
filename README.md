## utopianconcept.com

This is my GitHub user page made with Jekyll. Download it, fork it, follow it, give it away...

Care to leave feedback? [File an issue on this project](https://github.com/rclanan/Feedback/issues/new) and I will get back to you as soon as I can.

## To run

### Method 1:
```bash
docker build -t $IMAGENAME .
docker run -t -i -p $LOCALHOSTNAME:$PORT:4000 -v $PWD:/src $IMAGENAME
```

### Method 2: Compose Usage (using **docker-compose**)

```bash
docker-compose build
docker-compose up
```
