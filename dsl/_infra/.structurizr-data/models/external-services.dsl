group "External Systems" {
    payment_provider = softwareSystem "Payment Provider" "A payment provider for the Pie Platform." "External"
    auth0 = softwareSystem "Auth0" "An authentication and authorization service for the Pie Platform." "External"
    pie_dc = softwareSystem "Pie Data Centre" "A dedicated data centre for Pie production." "External"
    microsoft_365 = softwareSystem "Microsoft 365" "Microsoft 365 services." "External"
    sentry_io = softwareSystem "Sentry.io" "Error tracking and monitoring service." "External"

    group "Cloud Services" {
        azure = softwareSystem "Azure" "Microsoft Azure Cloud Services" "External" 
        aws = softwareSystem "Amazon Web Servces" "AWS Cloud Services" "External"
        gcp = softwareSystem "Google Cloud Platform" "Google Cloud Services" "External"
        tencent_cloud = softwareSystem "Tencent Cloud" "Tencent Cloud Services" "External"
        oracle_cloud = softwareSystem "Oracle Cloud" "Oracle Cloud Services" "External"
    }
}