#!/usr/bin/env bash

echo "
Hello!

Here are the Vault secrets:

    static_secret1 = ${static_secret1}
    static_secret2 = ${static_secret2}
    dynamic_secret1 = ${dynamic_secret1}
    dynamic_secret2 = ${dynamic_secret2}
    " > terraform_output.txt