[![Build Status](https://circleci.com/gh/cloudify-examples/elk-blueprint.svg?style=shield&circle-token=:circle-token)](https://circleci.com/gh/cloudify-examples/elk-blueprint)

# cloudify-elk-blueprint

A RabbitMQ Elasticsearch Logstash and Kibana Blueprint


## prerequisites

You will need a *Cloudify Manager* running in either AWS, Azure, or Openstack.

If you have not already, set up the [example Cloudify environment](https://github.com/cloudify-examples/cloudify-environment-setup). Installing that blueprint and following all of the configuration instructions will ensure you have all of the prerequisites, including keys, plugins, and secrets.


### Execute Install

Next you provide those inputs to the blueprint and execute install:


#### For AWS run:

```shell
$ cfy install \
    https://github.com/cloudify-examples/elk-blueprint/archive/4.0.1.1.zip \
    -b elk \
    -n aws-blueprint.yaml
```


#### For Azure run:

```shell
$ cfy install \
    https://github.com/cloudify-examples/elk-blueprint/archive/4.0.1.1.zip \
    -b elk \
    -n azure-blueprint.yaml
```


#### For Openstack run:

```shell
$ cfy install \
    https://github.com/cloudify-examples/elk-blueprint/archive/4.0.1.1.zip \
    -b elk \
    -n openstack-blueprint.yaml
```
