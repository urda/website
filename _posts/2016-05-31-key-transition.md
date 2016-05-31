---
title: Urda's PGP Key Transition Statement
layout: post

excerpt: |
    I changed OpenPGP keys. This is the public proof!

date: 2016-05-31 20:47:07
---

```
-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

For a number of reasons, I have recently set up a new OpenPGP key and
will be transitioning away from my old one. All correspondence should use
the new key now.

*** This message is signed by both keys to certify the transition. ***

The old key was:

pub   2048R/9CED75CD 2012-07-08
      Key fingerprint = AF7C 0F76 C05C 7B84 9BBF  E400 FDBB EE4F 9CED 75CD

The new key is:

pub   4096R/194E3161 2016-05-31
      Key fingerprint = CA0B 9733 4F94 49EB 5AFF  CB93 240B D54D 194E 3161

To fetch my new key from a public key server, you can simply run:

  gpg --keyserver pgp.mit.edu --recv-key 194E3161

If you already know my old key, you can now verify that the new key is
signed by the old one:

  gpg --check-sigs 194E3161

If you don't already know my old key, or you just want to be double
extra paranoid, you can check the fingerprint against the one above:

  gpg --fingerprint 194E3161

Regards,

  ~ Peter Urda
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBCgAGBQJXTfJsAAoJEP277k+c7XXNWoMH/1QDBt8zhfFCWYKGzFByoH/w
574DASk204CigkeD4nShfUY/Jb0qL1fw+wa3nt4sajbwFQjr4wbZ3aa89WncYIRX
ziLpmBTz+8YyUAXMV7+RPZ/+28Hwbh5HgxtlRHF19Qjy+aW5VVyAsqsonbquOsjb
z9onaOO98+nr8+hbeXEvHb1E+sQMagJszyVEzsZadHVzNu/3WNqWdkA6DZ57EEc6
3oW2e++xhN005Ho/L7HLlK71csfqSapOQLER7dmpSWFjEPsfxqtLG4V1Xnwlc+Ey
vb23ttRaa5rGRNiQONS/fY5mgE+aVy6addWjGOc3gXphih8G19MkixrHvNkcSmiJ
AhwEAQEKAAYFAldN8mwACgkQJAvVTRlOMWFagw/9FoXBM5tvw6WUU2kv/6xWsQbg
UaDYFiEdfi03G88crMo8KQrekapPyINiJYFIGKZFd6r5dSVrGgTnrQqvgmIExdT3
jE3dHUzJlALYD5hecZyd+7M1VcrW5xnFlafyLW0bHCDBVtFUz7E6LNvSNATxo7Pc
Bwj4iYCEOL670rJs5kbzHJeogFho/yX6k/0Aj5dOBwsGiXi0LCNlaxLwl4BwCMQQ
lPNyIDKCj0jFXqA2ZE/6s/Q/UmpdqNUPN8dzuL1QheXTEl4+e30v9q4X5QZaD9cH
s3uZCZxBsWIQdTGnfc8ZerGUN0QxeURquFrxEBIqh9nOlZ8BjbBbVXKj6Cxgj2hd
2LxT/uj8Yd5Wa9ikqv6pmCjqWFE8Dx+bQz7YeSvNk0QAB/EG4qhNE+Ppkvqe1zga
PHX3uU6XXGx/OrFxkCDtvRxJ7/j0WCNFX1N/IpqYHba1DS+Fk5J0Mz7mS/tB9Snn
YFwPkqimXBT6CkUZ+ZKyV2AJyajPImFT0Th4G5zJx8MR3hjkl2cFdtWZ5M4utfqQ
ogjQrIJcHl9K74loUa5jYJzgbbNQciricDRdZlvqvbUM0ddEzzIBB8oF6rAbnyZz
qvPj8pE56nbMcB8RRTgPAjO79dKTzSaVjbQWgFHSehQ7RX1fdVYrefsd3WvyGlKY
q2sCuLYZF85m4IvJGbY=
=lJkD
-----END PGP SIGNATURE-----
```
