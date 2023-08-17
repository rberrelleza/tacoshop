# Create a Development Environment with okteto, Kubernetes, and Cloud Services

This is an example of how to configure and deploy a development environment that includes polyglot microservices, an AWS SQS queue, and an S3 bucket. This sample uses LocalStack to mock the AWS interface, to keep costs down and keep it simple.

## Architecture

![Architecture diagram](https://raw.githubusercontent.com/rberrelleza/tacoshop/main/docs/architecture.png)

## Run the demo application in Okteto

### Prequisites:
1. [Okteto CLI 2.19](https://github.com/okteto/okteto) or newer
1. A Kubernetes cluster 

> If you don't have access to a Kubernetes cluster, you can also run this sample in the [free tier of Okteto](https://cloud.okteto.com)
> Just run `okteto context use https://cloud.okteto.com`

```
$ git clone https://github.com/rberrelleza/tacoshop
$ cd tacoshop
$ okteto context use $YOUR_KUBERNETES_CONTEXT
$ okteto deploy
```
## Access the application

By default, the services use ClusterIPs. To access them, you can use `kubectl port-forward`, [`kubefwd``](https://kubefwd.com/), or your favorite tool.

If you're using `kubefwd`,  run `sudo -E kubefwd svc -n default`. The services will be available in the following URLs:
- http://menu:3000
- http://kitchen:8000
- http://check:8000



## Develop on the Menu microservice 

```
$ okteto up menu
```

## Develop on the Kitchen microservice

```
$ okteto up kitchen
```

## Develop on the Result microservice

```
$ okteto up check
```

## Notes

This isn't an example of a properly architected perfectly designed distributed app... it's a simple
example of the various types of pieces and languages you might see (queues, persistent data, etc), and how to deal with them using okteto.
