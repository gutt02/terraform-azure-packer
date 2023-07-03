# Terraform - Azure - Packer

## Table of Contents

* [Introduction](#introduction)
* [Pre-Requirements](#pre-requirements)
* [Modules](#modules)
* [Resources](#resources)

## Introduction

Scripts to create a Shared Image Gallery, a Linux image with packer and a Linux Virtual Machine based on the image.

## Pre-Requirements

* Service Principal
* Remote Backend
* [terraform-azure-setup-remote-backed](https://github.com/gutt02/terraform-azure-setup-remote-backend)

## Modules

* [Terraform - Share Image Gallery](./src/terraform/shared-image-gallery/README.md)
* [Packer - Linux Virtual Machine](./src/packer/linux-virtual-machine/README.md)
* [Terraform - Linux Virtual Machine](./src/terraform/linux-virtual-machine/README.md)

## Resources

* [Packer by HashiCorp](https://www.packer.io/)
* [Packer Plugin Azure](https://github.com/hashicorp/packer-plugin-azure)
