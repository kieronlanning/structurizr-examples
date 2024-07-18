workspace "Pie Platform" "A platform for building, managing and monitoring Pie production." {
    model {
        properties {
            "structurizr.groupSeparator" "/"
        }

        # Users
        api_user = person "API User" "A customer that predeominantly uses the API."
        normal_user = person "Normal User" "A customer that uses the web or mobile applications."
        admin_user = person "Admin User" "A Support Desk or other Administrative user."

        # Software Systems
        pie_platform = softwareSystem "Pie Platform" "A platform for building, managing and monitoring Pie production." {
            # Application services
            firewall = container "Firewall" "Firewall solution." "Go"
            api_gateway = container "API Gateway" "The API Gateway for the Pie Platform." "Go"
            api = container "API Layer" "The API layer of the Pie Platform." "PHP"
            command_agent = container "Command Agent" "The command and control application IoT device." "Assembly" "iot"
            
            group "Cron Jobs" {
                all_cron_jobs = container "Cron Jobs" "The cron jobs for the Pie Platform." "NodeJS"
            }

            group "Microservices" {
                all_microservices = container "Microservices" "A collection of microservices." "PHP"
                vm_manager = container "VM Manager" "Manages the virtual machines for the Pie Platform." ".NET"
                legacy_connector = container "Legacy Connector" "Connects to legacy systems." ".NET"
                pie_tracker = container "Pie Tracker" "Manages the live state of the pies in production." ".NET"
                network_boot = container "Network Boot" "Manages the boot process for the Pie Platform." "C++"
                email_service = container "E-mail Service" "Sends e-mails." ".NET"
            }

            # Web applications
            customer_portal = container "Customer Portal" "The web application for the Pie Platform." "React" "WebApp"
            admin_portal = container "Admin Portal" "The administrative panel for the Pie Platform." ".NET" "WebApp"
            
            # Mobile applications
            mobile_app = container "Mobile App" "The mobile application for the Pie Platform." "React Native" "mobile_app"

            # Data stores
            customer_database = container "Customer Database" "The database for customer information." "FoxPro" "Database"
            pie_database = container "Pies Database" "The database for internally build Pies." "SQL Server" "Database"
            pie_cloud_database = container "Pie Cloud Database" "The database for Pies built and managed in external cloud services." "MongoDB" "Database"
            
            opensearch = container "OpenSearch" "The search engine for the Pie Platform." "opensearch" "Database"

            redis = container "Redis" "The cache for the Pie Platform." "Redis" "Database"

            rabbit_mq = container "Rabbit MQ" "The message broker for the Pie Platform." "rabbit_mq" "Messaging"
            
            clickhouse = container "ClickHouse" "Configuration and messaing sysem." "ClickHouse" "Messaging"
        }

        # External dependencies
        group "External Systems" {
            payment_provider = softwareSystem "Payment Provider" "A payment provider for the Pie Platform." "External"
            auth0 = softwareSystem "Auth0" "An authentication and authorization service for the Pie Platform." "External"
            pie_dc = softwareSystem "Pie Data Centre" "A dedicated data centre for Pie production." "External"
            microsoft365 = softwareSystem "Microsoft 365" "Microsoft 365 services." "External"
            sentry_io = softwareSystem "Sentry.io" "Error tracking and monitoring service." "External"
        
            group "Cloud Services" {
                azure = softwareSystem "Azure" "Microsoft Azure Cloud Services" "External" 
                aws = softwareSystem "Amazon Web Servces" "AWS Cloud Services" "External"
                gcp = softwareSystem "Google Cloud Platform" "Google Cloud Services" "External"
                tencent_cloud = softwareSystem "Tencent Cloud" "Tencent Cloud Services" "External"
            }
        }

        # Relationships
        api_user -> firewall "Uses"
        normal_user -> customer_portal "Uses"
        normal_user -> mobile_app "Uses"
        admin_user -> admin_portal "Uses"

        firewall -> api_gateway "Forwards and protects requests to"
        firewall -> clickhouse "Sends messages to"
        firewall -> sentry_io "Sends observability data to"

        api_gateway -> api "Forwards requests to"
        api_gateway -> auth0 "Authenticates with"
        api_gateway -> sentry_io "Sends observability data to"
        
        api -> rabbit_mq "Sends messages to"
        api -> sentry_io "Sends observability data to"
        rabbit_mq -> api "Receives messages from"

        mobile_app -> sentry_io "Sends observability data to"
        mobile_app -> firewall "Uses"
        mobile_app -> auth0 "Authenticates with"

        customer_portal -> sentry_io "Sends observability data to"
        customer_portal -> auth0 "Authenticates with"
        customer_portal -> firewall "Uses"
        customer_portal -> customer_database "Stores data in"
        customer_portal -> pie_database "Stores data in"
        customer_portal -> pie_cloud_database "Stores data in"
        
        admin_portal -> sentry_io "Sends observability data to"
        admin_portal -> auth0 "Authenticates with" 
        admin_portal -> firewall "Uses"
        admin_portal -> customer_database "Stores data in"
        admin_portal -> pie_database "Stores data in"
        admin_portal -> pie_cloud_database "Stores data in"

        all_cron_jobs -> sentry_io "Sends observability data to"
        all_cron_jobs -> customer_database "Stores data in"
        all_cron_jobs -> pie_database "Stores data in"
        all_cron_jobs -> opensearch "Stores data in"
        all_cron_jobs -> rabbit_mq "Sends messages to"

        all_microservices -> sentry_io "Sends observability data to"
        all_microservices -> customer_database "Stores data in"
        all_microservices -> pie_database "Stores data in"
        all_microservices -> opensearch "Stores data in"
        all_microservices -> redis "Caches data in"
        all_microservices -> rabbit_mq "Sends messages to"
        rabbit_mq -> all_microservices "Receives messages from"

        vm_manager -> sentry_io "Sends observability data to"
        vm_manager -> azure "Uses"
        vm_manager -> aws "Uses"
        vm_manager -> gcp "Uses"
        vm_manager -> tencent_cloud "Uses"
        vm_manager -> pie_cloud_database "Stores data in"
        vm_manager -> rabbit_mq "Sends messages to"
        vm_manager -> redis "Caches data in"
        rabbit_mq -> vm_manager "Receives messages from"

        legacy_connector -> sentry_io "Sends observability data to"
        legacy_connector -> pie_database "Stores data in"
        legacy_connector -> pie_cloud_database "Stores data in"
        legacy_connector -> rabbit_mq "Sends messages to"
        legacy_connector -> redis "Caches data in"
        rabbit_mq -> legacy_connector "Receives messages from"

        pie_tracker -> sentry_io "Sends observability data to"
        pie_tracker -> pie_database "Stores data in"
        pie_tracker -> pie_cloud_database "Stores data in"
        pie_tracker -> rabbit_mq "Sends messages to"
        pie_tracker -> redis "Caches data in"
        rabbit_mq -> pie_tracker "Receives messages from"

        network_boot -> sentry_io "Sends observability data to"
        network_boot -> pie_database "Stores data in"
        network_boot -> rabbit_mq "Sends messages to"
        network_boot -> redis "Caches data in"
        rabbit_mq -> network_boot "Receives messages from"

        email_service -> sentry_io "Sends observability data to"
        email_service -> microsoft365 "Sends e-mails via"
        rabbit_mq -> email_service "Receives messages from"

        command_agent -> sentry_io "Sends observability data to"
        command_agent -> rabbit_mq "Sends commands to"
        rabbit_mq -> command_agent "Recieves commands from"

        production = deploymentEnvironment "Production" {
            deploymentNode "On-Prem" {
                deploymentNode "Kubernetes" {
                    containerInstance firewall
                    containerInstance vm_manager
                    containerInstance legacy_connector
                    containerInstance pie_tracker
                }

                deploymentNode "Docker Swarm" {
                    containerInstance all_microservices
                    containerInstance network_boot
                }

                deploymentNode "Cron Jobs" {
                    containerInstance all_cron_jobs
                }

                deploymentNode "API Gateway" {
                    containerInstance api_gateway
                }

                deploymentNode "Web Servers" {
                    containerInstance api
                    containerInstance customer_portal
                    containerInstance admin_portal
                }

                deploymentNode "Database Cluster" {
                    containerInstance customer_database
                    containerInstance pie_database
                    containerInstance pie_cloud_database
                }

                deploymentNode "opensearch Cluster" {
                    containerInstance opensearch
                }

                deploymentNode "Redis Cluster" {
                    containerInstance redis
                }

                deploymentNode "rabbit_mq Cluster" {
                    containerInstance rabbit_mq
                }
                
                deploymentNode "ClickHouse Cluster" {
                    containerInstance clickhouse
                }
                
                deploymentNode "Internally Hosted" {
                    containerInstance command_agent
                }
            }

            deploymentNode "Cloud" {
                deploymentNode "Azure" {
                    containerInstance command_agent
                }

                deploymentNode "AWS" {
                    containerInstance command_agent
                }

                deploymentNode "GCP" {
                    containerInstance command_agent
                }

                deploymentNode "Tencent Cloud" {
                    containerInstance command_agent
                }
            }
        } 
    }

    views {
        systemContext pie_platform "SystemContextDiagram" {
            include *
            autolayout lr
        }

        container pie_platform "ContainerDiagram" {
            include *
            autolayout lr
        }

        deployment * production "ProductionDeployment" "The deployment of the Pie Platform in a production environment." {
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

            element "mobile_app" {
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