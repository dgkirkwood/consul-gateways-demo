Kind = "ingress-gateway"
Name = "ingress-gateway"

Listeners = [
 {
   Port = 5000
   Protocol = "http"
   Services = [
     {
       Name = "frontend"
     }
   ]
 }
]