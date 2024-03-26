# video_environment

## Description

This project builds 3 Linux servers and 2 Windows servers for use in a demo video. It doesn't install anything as that's the aim of the video.

## How to use

There are a couple of bit of information that Terraform is going to need to build the environment.

* Add your own AWS key pair name to ```inputs.tf```.

* It's going to run a bash script to obtain your local IP and pass it in to the network configuration.

To build run ```terraform apply```.