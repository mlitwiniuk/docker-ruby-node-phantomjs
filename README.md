# prograils/ruby-node-phantomjs

Ruby, node with phantomjs bundled in. `latest` is always based on latest stable
ruby version.

## What's inside

The supplied `Dockerfile` will create an images for docker containers
with ruby, nodejs and phantomjs. Mainly to run the headless tests of karma.

The reason that phantomjs is contained in a git repository is because
of the time (> 1.5h) it takes to build phantomjs from source on my macbook.
To avoid this time, a separate Dockerfile is used to build the binary.

## Getting started

### Getting the image

```
$ docker pull prograils/ruby-node-phantomjs
```

### Running

```
$ docker run -t -i prograils/ruby-node-phantomjs
```

### Testing
```
$ bundle exec rspec
```


## References

* [Test Drive Your Dockerfiles with RSpec and ServerSpec](https://robots.thoughtbot.com/tdd-your-dockerfiles-with-rspec-and-serverspec)
* [PhantomJS binairy for Ubuntu 14.04](https://github.com/edwinvdgraaf/phantomjs-build)
