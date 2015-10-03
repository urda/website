---
title: 'Urda&#8217;s PGP Public Key'
author: Peter Urda
layout: post
redirect_from: /2012/07/urdas-pgp-public-key/
sharing_disabled:
  - 1
categories:
  - Ramblings
tags:
  - Cryptography
  - Public Key
---
Here is a copy of my PGP public key for verification and encryption purposes.

This key can be used for signature verification and encryption purposes.

My public key has the following properties, and can be found on key servers:

<pre class="brush: plain; title: ; notranslate" title="">Key ID:
9CED75CD

Key Fingerprint:
AF7C 0F76 C05C 7B84 9BBF  E400 FDBB EE4F 9CED 75CD
</pre>

You should be able to obtain it from a key server, such as <a href="http://pgp.mit.edu/" class="external external_icon" target="_blank">MIT&#8217;s</a>. Use the following command in your *nix shell:

<pre class="brush: bash; title: ; notranslate" title="">gpg --keyserver pgp.mit.edu --recv-key 9CED75CD
</pre>

My public key can be downloaded from my web server here: [PeterUrda.2012.07.08][1]

You can download it in your *nix shell using wget from my web server like so:

<pre class="brush: bash; title: ; notranslate" title="">wget http://www.peter-urda.com/wp/wp-content/uploads/2012/07/PeterUrda.2012.07.08.gpg
</pre>

You can also copy the public key from the block below:

<pre class="brush: plain; title: ; notranslate" title="">-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: SKS 1.1.0

mQENBE/5mSQBCADfMFJSgF6IlmYre4VtuagJ2kzwfELkSd5q3+9OaOPocS20hMtsjCYhUip4
Ane2koY10ri8MyBTBjK8zMkAyEuk+cltisQsKG8Gf5dzangjUGH80fM2bLliyvtc8MD2VGW1
W+xfniMTlW/DkKeYTQXtqKQuFWnI3vVbEYewblc9XW9Ylo5Kyh3Vlmeuxw5BusmXY1ikTCNs
aEhpUAlTq5WetpRHhNhiQ6wHmYwpvQucJIlPGcHeBfPLCQYg47ksTyx+q3aF5TbzAtkH66m8
LQEUTTpItAjjFkACwFtvswgk1sbwCnpUZGTRQc21HHt7v57I19F1o6AH3Prr0KQd/EwHABEB
AAG0IVBldGVyIFVyZGEgPHBldGVyLnVyZGFAZ21haWwuY29tPokBOAQTAQIAIgUCT/mZJAIb
AwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQ/bvuT5ztdc0TqAf5AY9seRPnBa5rozYv
JG6vvQn/4VyJc3cU0vy+RaTyKzfDbwpm/t4cHi/GMVo/piTYNblDsEGwza7CnAk1vbBDO8sf
0jBUU4HGQI593H3w5HgrvL8bgzNiWlAoDvO+Kank7ngnqhlxh2dPJunRBQDX0GJ75r++jic0
Qt5gL+S0lZ3rK3+mZwSDCZI06pSBoB4zGoYOxxDnU88/i/ebKuZxvQMGpZno4gKuAe6C1hUc
S4+S6YfYfm1OwcEl5tn6k+QaCJ8S+BI/MwRXyO8JpBoahrYPzqlzNA2d40RwNHaVfl3kfuXM
NhzNxue+yHgJb2wbU1UKXHrQalF8t064E+/y07kBDQRP+ZkkAQgA04NzKa2bvFqu2sWItVES
sAWLyDQ9i7CC448MazB03rKK/PNS5fjeZ3PtmNNZN6gxB8VN+6/3gUwvXoJUQO0ugFVM4fWx
ggmwyk9n304LYzAAouaC5kYDvxCxrVUfiu67mntEnW7tV5ImWOMSsAoLYts4AbDafsRlkWSZ
+pp3UUiZSLYtP99rsHZNw/aEi+ZrRr161pIMP7GIIO6t6sjXpiXPC8QElNxwNkhOZ/3iWll/
tMoa8e/cZGCqbPET806DvMa7r5J425dEAFbbYyLLjKa/6Sd8ROJbNc6wxfw9t8MmpiKQVktr
jk4FyzY56XTYRWzK/ZYaHCsxpT5dOsVylwARAQABiQEfBBgBAgAJBQJP+ZkkAhsMAAoJEP27
7k+c7XXNdPoH/A5An8LkkDxdzF8Xj5NJsWJaNMPRwhO3l42cQgeUcQcJQZ8Z2gBr8vujaBjv
SEdwChLk1t3mZeKChJrCgt1kstg5Q9LUOJjPLJ9Dy6hgW8lYp8WQ7IA9WzYku0TioiC8s2ih
midhsw3qOULYzS4vlFsRpYQO2IgC4EYO42b944aSnnya5D+2QpHYErxm7Se5yqWfLuEFf5GH
rxBf7O/mV160Xw/6I49LiOuOA/4LtrfXQ57DiWla97eMawdDBqLRUyY0ZLIxW2stX1TS8jbn
/oGZoJl0Jo21wbYJ6vubinW3yQ8rKAPAKP70aIrnvi7Fi5RADuks5zPFJYZ+yizcKnA=
=w0UO
-----END PGP PUBLIC KEY BLOCK-----

</pre>

You can learn more about PGP by reading this Wikipedia article: <a href="http://en.wikipedia.org/wiki/Pretty_Good_Privacy" class="external external_icon" target="_blank">http://en.wikipedia.org/wiki/Pretty_Good_Privacy</a>. You can also learn more about helpful applications over here: <a href="http://www.gnupg.org/" class="external external_icon" target="_blank">http://www.gnupg.org/</a>.

 [1]: http://www.peter-urda.com/wp/wp-content/uploads/2012/07/PeterUrda.2012.07.08.gpg