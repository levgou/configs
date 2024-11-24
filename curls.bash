# Mint rca classes
curl -X POST http://localhost:80 \
     -H "Content-Type: application/json" \
     -d '{
           "debug_str": "This is a debug message",
           "client_slug": "mint",
           "rcas": [
               "The SIM card was not properly inserted, causing connectivity issues.",
               "The SIM card is not compatible with the current network settings."
           ]
         }'

# Calendly rca clsses 
curl -X POST http://localhost:80 \
     -H "Content-Type: application/json" \
     -d '{
           "debug_str": "This is a debug message",
           "client_slug": "calendly",
           "rcas": [
               "The scheduling conflict occurred due to overlapping meetings.",
               "The time zone mismatch led to incorrect meeting times being scheduled."
           ]
         }'

# Bill rca classes
curl -X POST http://localhost:80 \
     -H "Content-Type: application/json" \
     -d '{
           "debug_str": "This is a debug message",
           "client_slug": "bill",
           "rcas": [
               "The invoice was generated with incorrect billing details.",
               "A delay in payment processing caused a billing error."
           ]
         }'


# Ryze rca classes
curl -X POST http://localhost:80 \
     -H "Content-Type: application/json" \
     -d '{
           "debug_str": "This is a debug message",
           "client_slug": "ryze",
           "rcas": [
               "The coffee beans were over-roasted, affecting the flavor profile.",
               "A delay in shipping resulted in the coffee losing freshness."
           ]
         }'


# Password 
curl -X POST https://stage.loris.ai/lorisauth/user-password-auth/  \ 
  -H "Content-Type: application/json"  \
  -d '{"username": "lev@loris.ai", "password": "????"}' | jq



# Auth
-H "Authorization: Bearer $t"
