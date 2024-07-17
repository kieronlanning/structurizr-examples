workspace "Pie Platform" "A platform for building, managing and monitoring Pie production." {
    model {
        properties {
            "structurizr.groupSeparator" "/"
        }

        # Users
        apiUser = person "API User" "A customer that predeominantly uses the API."
        normalUser = person "Normal User" "A customer that uses the web or mobile applications."
        adminUser = person "Admin User" "A Support Desk or other Administrative user."

        # Software Systems
        piePlatform = softwareSystem "Pie Platform" "A platform for building, managing and monitoring Pie production." {
            # Application services
            cdn = container "CDN" "A Content Delivery Network and Anti-DDOS solution." "Go"
            apiGateway = container "API Gateway" "The API Gateway for the Pie Platform." "Go"
            api = container "API Layer" "The API layer of the Pie Platform." "PHP"
            commandAgent = container "Command Agent" "The command and control server for the Pie Platform." ".NET"
            
            group "Cron Jobs" {
                cronjobs = container "Cron Jobs" "The cron jobs for the Pie Platform." "PHP"
            }

            group "Microservices" {
                all_microservices = container "Microservices" "A collection of microservices." "PHP"
                vm-manager = container "VM Manager" "Manages the virtual machines for the Pie Platform." ".NET"
                legacy-connector = container "Legacy Connector" "Connects to legacy systems." ".NET"
                live-state = container "Live State" "Manages the live state of the Pie Platform." ".NET"
                ipxe = container "iPXE" "Manages the boot process for the Pie Platform." "PHP"
            }

            # Web applications
            customerPortal = container "Customer Portal" "The web application for the Pie Platform." "React" "WebApp"
            adminPortal = container "Admin Portal" "The administrative panel for the Pie Platform." ".NET" "WebApp"
            
            # Mobile applications
            mobileApp = container "Mobile App" "The mobile application for the Pie Platform." "React Native" "MobileApp"

            # Data stores
            customerDatabase = container "Customer Database" "The database for customer information." "MySQL" "Database"
            pieDatabase = container "Pies Database" "The database for internally build Pies." "SQL Server" "Database"
            pieCloudDatabase = container "Pie Cloud Database" "The database for Pies built and managed in external cloud services." "MongoDB" "Database"
            
            openSearch = container "OpenSearch" "The search engine for the Pie Platform." "OpenSearch" "Database"

            redis = container "Redis" "The cache for the Pie Platform." "Redis" "Database"

            rabbitMQ = container "RabbitMQ" "The message broker for the Pie Platform." "RabbitMQ" "Messaging"
            
            clickhouse = container "ClickHouse" "Configuration and messaing sysem." "ClickHouse" "Messaging"
        }

        # External dependencies
        group "External Systems" {
            paymentProvider = softwareSystem "Payment Provider" "A payment provider for the Pie Platform." "External"
            auth0 = softwareSystem "Auth0" "An authentication and authorization service for the Pie Platform." "External"
            pieDC = softwareSystem "PieDC" "A dedicated data centre for Pie production." "External"
        
            group "Cloud Services" {
                azure = softwareSystem "Azure" "Microsoft Azure Cloud Services" "External" 
                aws = softwareSystem "Amazon Web Servces" "AWS Cloud Services" "External"
                gcp = softwareSystem "Google Cloud Platform" "Google Cloud Services" "External"
                tencentCloud = softwareSystem "Tencent Cloud" "Tencent Cloud Services" "External"
            }
        }

        # Relationships
        apiUser -> cdn "Uses"
        normalUser -> customerPortal "Uses"
        normalUser -> mobileApp "Uses"
        adminUser -> adminPortal "Uses"

        cdn -> apiGateway "Forwards and protects requests to"

        apiGateway -> api "Forwards requests to"
        apiGateway -> auth0 "Authenticates with"
        api -> rabbitMQ "Sends messages to"
        rabbitMQ -> api "Receives messages from"

        mobileApp -> cdn "Uses"
        mobileApp -> auth0 "Authenticates with"

        customerPortal -> auth0 "Authenticates with"
        customerPortal -> cdn "Uses"
        customerPortal -> customerDatabase "Stores data in"
        customerPortal -> pieDatabase "Stores data in"
        customerPortal -> pieCloudDatabase "Stores data in"
        
        adminPortal -> auth0 "Authenticates with" 
        adminPortal -> cdn "Uses"
        adminPortal -> customerDatabase "Stores data in"
        adminPortal -> pieDatabase "Stores data in"
        adminPortal -> pieCloudDatabase "Stores data in"

        all_microservices -> customerDatabase "Stores data in"
        all_microservices -> pieDatabase "Stores data in"
        all_microservices -> openSearch "Stores data in"
        all_microservices -> redis "Caches data in"
        all_microservices -> rabbitMQ "Sends messages to"
        rabbitMQ -> all_microservices "Receives messages from"

        vm-manager -> azure "Uses"
        vm-manager -> aws "Uses"
        vm-manager -> gcp "Uses"
        vm-manager -> tencentCloud "Uses"
        vm-manager -> pieCloudDatabase "Stores data in"
        vm-manager -> rabbitMQ "Sends messages to"
        vm-manager -> redis "Caches data in"
        rabbitMQ -> vm-manager "Receives messages from"

        legacy-connector -> pieDatabase "Stores data in"
        legacy-connector -> pieCloudDatabase "Stores data in"
        legacy-connector -> rabbitMQ "Sends messages to"
        legacy-connector -> redis "Caches data in"
        rabbitMQ -> legacy-connector "Receives messages from"

        live-state -> pieDatabase "Stores data in"
        live-state -> pieCloudDatabase "Stores data in"
        live-state -> rabbitMQ "Sends messages to"
        live-state -> redis "Caches data in"
        rabbitMQ -> live-state "Receives messages from"

        ipxe -> pieDatabase "Stores data in"
        ipxe -> rabbitMQ "Sends messages to"
        ipxe -> redis "Caches data in"
        rabbitMQ -> ipxe "Receives messages from"

        commandAgent -> rabbitMQ "Sends commands to"
        rabbitMQ -> commandAgent "Recieves commands from"

        cdn -> clickhouse "Sends messages to"

        production = deploymentEnvironment "Production" {
            deploymentNode "Docker Swarm" {
                containerInstance cdn
                containerInstance all_microservices
                containerInstance vm-manager
                containerInstance legacy-connector
                containerInstance live-state
                containerInstance ipxe
            }

            deploymentNode "Cron Jobs" {
                containerInstance cronjobs
            }

            deploymentNode "API Gateway" {
                containerInstance apiGateway
            }

            deploymentNode "Web Servers" {
                containerInstance api
                containerInstance customerPortal
                containerInstance adminPortal
            }

            deploymentNode "Database Cluster" {
                containerInstance customerDatabase
                containerInstance pieDatabase
                containerInstance pieCloudDatabase
            }

            deploymentNode "OpenSearch Cluster" {
                containerInstance openSearch
            }

            deploymentNode "Redis Cluster" {
                containerInstance redis
            }

            deploymentNode "RabbitMQ Cluster" {
                containerInstance rabbitMQ
            }
            
            deploymentNode "ClickHouse Cluster" {
                containerInstance clickhouse
            }
        } 
    }

    views {
        systemContext piePlatform "SystemContextDiagram" {
            include *
            autolayout lr
        }

        container piePlatform "ContainerDiagram" {
            include *
            autolayout lr
        }

        deployment * production {
            include *
            autolayout
        }

        styles {
            element "Person" {
                background #116611
                color #ffffff
                shape Person
            }

            element "WebApp" {
                background #0044FF
                color #ffffff
                shape WebBrowser
            }

            element "MobileApp" {
                background #0044FF
                color #ffffff
                shape MobileDevicePortrait
            }

            element "Database" {
                background #0044FF
                color #ffffff
                shape Cylinder
            }

            element "Messaging" {
                background #FFA200
                color #ffffff
                shape Folder
            }

            element "External" {
                background #706F6C
                color #ffffff
                shape Hexagon
            }
        }
    }
}