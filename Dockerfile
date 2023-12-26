FROM node:20 as build
RUN npm install -g @apollo/rover
WORKDIR /usr/app/src
ADD . /usr/app/src/
RUN rover supergraph compose --elv2-license=accept --config config/supergraph.yaml > supergraph.graphql

FROM ghcr.io/apollographql/router:v1.35.0
ENV APOLLO_ROUTER_SUPERGRAPH_PATH=/etc/apollo/supergraph.graphql
ENV APOLLO_TELEMETRY_DISABLED=true
ENV LISTEN_ADDRESS=3000
COPY --from=build /usr/app/src/supergraph.graphql /etc/apollo/supergraph.graphql
