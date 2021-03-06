#
# 1. Servers reachable from the Internet must not expose the insecure 'http' protocol.
# 2. Servers are not allowed to expose the 'telnet' protocol.
#
package example
import future.keywords # we want "every" and "in"

allow = true {                                      # allow is true if...
    count(violation) == 0                           # there are zero violations.
}

violation[server.id] {                              # a server is in the violation set if...
    some server in public_servers                   # it exists in the 'public_servers' set and...
    "http" in server.protocols                      # it contains the insecure "http" protocol.
}

violation[server.id] {                              # a server is in the violation set if...
    some server in input.servers                    # it exists in the input.servers collection and...
    "telnet" in server.protocols                    # it contains the "telnet" protocol.
}

public_servers[server] {                             # a server exists in the public_servers set if...
    some server in input.servers                    # it exists in the input.servers collection and...

    some port in server.ports                       # it references a port in the input.ports collection and...
    some input_port in input.ports
    port == input_port.id

    some input_network in input.networks            # the port references a network in the input.networks collection and...
    input_port.network == input_network.id
    input_network.public                            # the network is public.
}
