#!/usr/bin/bash
source ~/.bashrc
echo "$(eth_gas_price | 2gwei)"
