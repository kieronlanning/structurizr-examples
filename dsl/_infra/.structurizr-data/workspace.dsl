workspace {
    model {
        # Users
        apiUser = person "API User" "A customer that predeominantly uses the API."
        browserUser = person "Browser User" "A customer that predominantly uses the web application."
        serviceDeskUser = person "Service Desk User" "A service desk or administrative user."

        # Software Systems
        onePlatform = softwareSystem "One Platform" {
            # Application services
            api = container "API Layer" "The API layer of the One Platform." "PHP"
            microservices = container "Microservices" "A collection of microservices." "PHP, .NET"
            hostagent = container "Host Agent" "The command and control server for the One Platform." ".NET"
            cdn = container "CDN" "The content delivery network for the One Platform." "Go"

            # Web applications
            onePortal = container "One Portal" "The web application for the One Platform." "React"
            adminPanel = container "Admin Panel" "The administrative panel for the One Platform." "Admin"

            # Persistent services
            customerBackend = container "customerBackend Database" "The database for the customer backend." "MySQL" "database"
            odp = container "ODP Database" "The database for the ODP." "MySQL" "database"
            odpCloud = container "ODP Cloud Database" "The database for ODP Cloud services." "MySQL" "database"
            
            openSearch = container "OpenSearch" "The search engine for the One Platform." "OpenSearch" "datanase"

            redis = container "Redis" "The cache for the One Platform." "Redis" "database"

            rabbitMQ = container "RabbitMQ" "The message broker for the One Platform." "RabbitMQ" "messaging"
        }

        # External dependencies
        paymentProvider = softwareSystem "Payment Provider"
        smartDC = softwareSystem "SmartDC"
        azure = softwareSystem "Azure"
        aws = softwareSystem "Amazon Web Servces"
        gcp = softwareSystem "Google Cloud Platform"
        tencentCloud = softwareSystem "Tencent Cloud"
    }

    views {
        styles {
            element "Person" {
                background #116611
                color #ffffff
                shape person
            }
        }
    }
}