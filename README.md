# Kubedrop

Simple test to deploy a kubernetes cluster from zero using [terraform](https://terraform.io) and [kubespray](http://kubespray.io/).

## Steps for deployment

* Create new project on hetzner cloud
* Add ssh key of the host running this to the new project (keep it's name, you'll need it)
* Get new project API key (keep it, you'll need it)
* Run `bash run.sh`
* Follow the instructions

## Destroy deployment

* Run `terraform destroy`
