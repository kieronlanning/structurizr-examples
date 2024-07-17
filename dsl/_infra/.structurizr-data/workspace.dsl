workspace {
    model {
        # Users
        apiUser = person "API User" "A customer that predeominantly uses the API."
        browserUser = person "Browser User" "A customer that predominantly uses the web application."
        adminUser = person "Admin User" "A Support Desk or other Administrative user."

        # Software Systems
        piePlatform = softwareSystem "Pie Platform" "A platform for building, managing and monitoring Pie production." {
            # Application services
            api = container "API Layer" "The API layer of the Pie Platform." "PHP"
            microservices = container "Microservices" "A collection of microservices." "PHP"
            commandAgent = container "Command Agent" "The command and control server for the Pie Platform." ".NET"
            apiGateway = container "API Gateway" "The API Gateway for the Pie Platform." "Go"

            # Web applications
            customerPortal = container "Customer Portal" "The web application for the Pie Platform." "React"
            adminPortal = container "Admin Portal" "The administrative panel for the Pie Platform." ".NET"
            
            # Mobile applications
            mobileApp = container "Mobile App" "The mobile application for the Pie Platform." "React Native"

            # Data stores
            customerDatabase = container "Customer Database" "The database for customer information." "MySQL" "database"
            pieDatabase = container "Pies Database" "The database for internally build Pies." "SQL Server" "database"
            pieCloudDatanase = container "Pie Cloud Database" "The database for Pies built and managed in external cloud services." "MongoDB" "database"
            
            openSearch = container "OpenSearch" "The search engine for the Pie Platform." "OpenSearch" "database"

            redis = container "Redis" "The cache for the Pie Platform." "Redis" "database"

            rabbitMQ = container "RabbitMQ" "The message broker for the Pie Platform." "RabbitMQ" "messaging"
        }

        # External dependencies
        paymentProvider = softwareSystem "Payment Provider" "A payment provider for the Pie Platform."
        auth0 = softwareSystem "Auth0" "An authentication and authorization service for the Pie Platform."
        pieDC = softwareSystem "PieDC" "A dedicated data centre for Pie production."
        azure = softwareSystem "Azure" "Microsoft Azure Cloud Services"
        aws = softwareSystem "Amazon Web Servces" "AWS Cloud Services"
        gcp = softwareSystem "Google Cloud Platform" "Google Cloud Services"
        tencentCloud = softwareSystem "Tencent Cloud" "Tencent Cloud Services"

        # Relationships
        apiUser -> apiGateway
        browserUser -> customerPortal
        adminUser -> adminPortal

        apiGateway -> api
        apiGateway -> auth0
        api -> rabbitMQ

        mobileApp -> apiGateway
        mobileApp -> auth0

        customerPortal -> auth0
        customerPortal -> apiGateway
        customerPortal -> customerDatabase
        customerPortal -> pieDatabase
        customerPortal -> pieCloudDatanase
        
        adminPortal -> auth0
        adminPortal -> apiGateway
        adminPortal -> customerDatabase
        adminPortal -> pieDatabase
        adminPortal -> pieCloudDatanase

        microservices -> customerDatabase
        microservices -> pieDatabase
        microservices -> pieCloudDatanase
        microservices -> openSearch
        microservices -> redis
        microservices -> rabbitMQ

        microservices -> paymentProvider
        microservices -> auth0
        microservices -> azure
        microservices -> aws
        microservices -> gcp
        microservices -> tencentCloud
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