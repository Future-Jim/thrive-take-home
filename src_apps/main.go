package main

import (
    "fmt"
    "net/http"
    "strconv"

    "github.com/prometheus/client_golang/prometheus"
    "github.com/prometheus/client_golang/prometheus/promhttp"
)

var httpRequests = prometheus.NewCounterVec(
    prometheus.CounterOpts{
        Name: "http_requests_total",
        Help: "Total HTTP requests processed by the app",
    },
    []string{"method", "path", "status"},
)

func init() {
    prometheus.MustRegister(httpRequests)
}

type statusResponseWriter struct {
    http.ResponseWriter
    status int
}

func (w *statusResponseWriter) WriteHeader(code int) {
    w.status = code
    w.ResponseWriter.WriteHeader(code)
}

func handler(w http.ResponseWriter, r *http.Request) {
    srw := &statusResponseWriter{ResponseWriter: w, status: 200}

    fmt.Fprintf(srw, "Hello Thrive People!! This is running in EKS via an artifact in ECR!\n")

    httpRequests.WithLabelValues(r.Method, r.URL.Path, strconv.Itoa(srw.status)).Inc()
}

func main() {
    http.HandleFunc("/", handler)
    http.Handle("/metrics", promhttp.Handler()) // Prometheus metrics endpoint
    http.ListenAndServe(":8080", nil)
}