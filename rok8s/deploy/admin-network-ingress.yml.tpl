apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: admin-network-ingress
  namespace: admin-network
  labels:
    app: admin-network-ingress
  annotations:
    kubernetes.io/ingress.class: "nginx"
    nginx.ingress.kubernetes.io/affinity: "cookie"
    nginx.ingress.kubernetes.io/session-cookie-name: "route"
    nginx.ingress.kubernetes.io/session-cookie-hash: "sha1"
spec:
  tls:
    - secretName: {{ PROJECT_NAME }}-tls-secrets
  rules:
  - host: apprenticeship-redis.andela.com
    http:
      paths:
      - path: /
        backend:
          serviceName: apprenticeship-redis
          servicePort: http
  - host: apprenticeship-redis-api.andela.com
    http:
      paths:
      - path: /
        backend:
          serviceName: travela-backend
          servicePort: http