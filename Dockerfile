FROM golang:1.26-alpine AS build
WORKDIR /src
COPY go.mod ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /out/hola-mibanco .

FROM gcr.io/distroless/static-debian12:nonroot
COPY --from=build /out/hola-mibanco /hola-mibanco
USER nonroot:nonroot
EXPOSE 8080
ENTRYPOINT ["/hola-mibanco"]
