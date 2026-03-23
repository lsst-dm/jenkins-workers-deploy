# Volumes Guide

There are different storage classes for different types of volumes. 
- The `arch` pods use the `arch-volume`.
- The `linux-x86` pods use the `arm-volume`. 
- The `standard-rwo` volume has `WaitForFirstConsumer` and should generally be used for Helm Charts, as the `standard` volume with the `Immediate` parameter can cause startup issues. 

## Reclaim Policies
All of the storage classes define a `Delete` reclaim policy. This should be manually edited to `Retain` on individual Persistent Volumes where loss of data would be catastrophic (ie, Jenkins). 