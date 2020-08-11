---
apiVersion: v1
kind: Service
metadata:
  name: serenity
  annotations:
    external-dns.alpha.kubernetes.io/hostname: "serenity.${DOMAIN}."
spec:
  type: ExternalName
  externalName: 192.168.1.40
---
apiVersion: v1
kind: Service
metadata:
  name: serenity-portal
  annotations:
    external-dns.alpha.kubernetes.io/target: "portal.serenity.${DOMAIN}."  
spec:
  type: ExternalName
  externalName: 192.168.1.40
  ports:
  - name: http
    port: 8080
---
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  annotations:
    kubernetes.io/ingress.class: internal
    nginx.ingress.kubernetes.io/backend-protocol: "HTTP"
  labels:
    app.kubernetes.io/instance: serenity-portal
    app.kubernetes.io/name: serenity-portal
  name: serenity-portal
spec:
  rules:
  - host: "portal.serenity.${DOMAIN}"
    http:
      paths:
      - backend:
          serviceName: serenity-portal
          servicePort: 8080
  tls:
  - hosts:
    - "portal.serenity.${DOMAIN}"