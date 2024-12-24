### BGP Config file

```conf
# FRRouting Configuration
#
router bgp 64513
  bgp router-id 192.168.1.1
  no bgp ebgp-requires-policy
  maximum-paths 1

  redistribute connected
  redistribute static

  neighbor k8s-main peer-group
  neighbor k8s-main remote-as 64514
  neighbor k8s-k0s peer-group
  neighbor k8s-k0s remote-as 64515

  neighbor 192.168.8.36 peer-group k8s-main
  neighbor 192.168.8.37 peer-group k8s-main
  neighbor 192.168.8.38 peer-group k8s-main
  neighbor 192.168.8.39 peer-group k8s-main
  neighbor 192.168.8.40 peer-group k8s-main
  neighbor 192.168.8.41 peer-group k8s-main
  neighbor 192.168.8.226 peer-group k8s-k0s

  address-family ipv4 unicast
    neighbor k8s-main activate
    neighbor k8s-main send-community all
    neighbor k8s-main soft-reconfiguration inbound

  address-family ipv4 unicast
    neighbor k8s-k0s activate
    neighbor k8s-k0s send-community all
    neighbor k8s-k0s soft-reconfiguration inbound
```

### CiliumBGPPeeringPolicy config file

[l3.yaml](./config/l3.yaml)
