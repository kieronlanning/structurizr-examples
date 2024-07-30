workspace "Pie Platform" "A platform for building, managing and monitoring Pie production." {
    model {
        properties {
            "structurizr.groupSeparator" "/"
        }

        # Users
        api_user = person "API User" "A customer that predeominantly uses the API."
        normal_user = person "Normal User" "A customer that uses the web or mobile applications."
        admin_user = person "Admin User" "A Support Desk or other Administrative user."
        observability_user = person "Observability User" "An external user that monitors the system for errors and performance."

        # Software Systems
        pie_platform = softwareSystem "Pie Platform" "A platform for building, managing and monitoring Pie production." {
            # Application services
            firewall = container "Firewall" "Firewall solution." "Go"
            api_gateway = container "API Gateway" "The API Gateway for the Pie Platform." "Go"
            api = container "API Layer" "The API layer of the Pie Platform." "PHP"
            pie_maker_device = container "Pie Maker Device" "The command and control IoT device for making pies." "Assembly" "iot"
            
            group "Cron Jobs" {
                all_cron_jobs = container "Cron Jobs" "The cron jobs for the Pie Platform." "NodeJS"
            }

            group "Microservices" {
                legacy_microservices = container "Legacy Microservices" "A collection of legacy microservices." "PHP" "microservice"
                vm_manager = container "VM Manager" "Manages the lifetime of virtual machines in private and public clouds." ".NET" "microservice"
                legacy_connector = container "Legacy Connector" "Connects to legacy systems." ".NET" "microservice"
                pie_tracker = container "Pie Tracker" "Manages the live state of the pies in production." ".NET" "microservice"
                network_boot = container "Network Boot" "Manages the boot process for the Pie Platform." "C++" "microservice"
                email_service = container "E-mail Service" "Sends e-mails." ".NET" "microservice"
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
            opensearch_dashboard = container "OpenSearch Dashbaord" "A dashbaord built to integrate with OpenSearch." "opensearch" "Telemetry"

            garnet = container "Garnet" "The distributed cache for the Pie Platform." "Garent" "Database"

            rabbit_mq = container "Rabbit MQ" "The message broker for the Pie Platform." "rabbit_mq" "Messaging"
            kafka = container "Kafka" "The data streaming service for the Pie Platform." "kafka" "Messaging"            
            clickhouse = container "ClickHouse" "Configuration and messaing sysem." "ClickHouse" "Messaging"
        }

        # External dependencies
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

        # Relationships
        api_user -> firewall "Uses the API via"
        normal_user -> firewall "Uses the Customer Portal via"
        normal_user -> mobile_app "Uses"
        admin_user -> admin_portal "Uses"
        admin_user -> opensearch_dashboard "Uses"

        firewall -> api_gateway "Forwards and protects requests to"
        firewall -> clickhouse "Sends messages to"
        firewall -> sentry_io "Sends observability data to"
        firewall -> customer_portal "Forwards requests to"
        firewall -> admin_portal "Forwards requests to"

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
        customer_portal -> customer_database "Stores data in"
        customer_portal -> pie_database "Stores data in"
        customer_portal -> pie_cloud_database "Stores data in"
        
        admin_portal -> sentry_io "Sends observability data to"
        admin_portal -> auth0 "Authenticates with" 
        admin_portal -> customer_database "Stores data in"
        admin_portal -> pie_database "Stores data in"
        admin_portal -> pie_cloud_database "Stores data in"

        all_cron_jobs -> sentry_io "Sends observability data to"
        all_cron_jobs -> customer_database "Stores data in"
        all_cron_jobs -> pie_database "Stores data in"
        all_cron_jobs -> opensearch "Stores data in"
        all_cron_jobs -> rabbit_mq "Sends messages to"

        legacy_microservices -> sentry_io "Sends observability data to"
        legacy_microservices -> customer_database "Stores data in"
        legacy_microservices -> pie_database "Stores data in"
        legacy_microservices -> opensearch "Stores data in"
        legacy_microservices -> garnet "Caches data in"
        legacy_microservices -> rabbit_mq "Sends messages to"
        rabbit_mq -> legacy_microservices "Receives messages from"

        vm_manager -> sentry_io "Sends observability data to"
        vm_manager -> azure "Uses"
        vm_manager -> aws "Uses"
        vm_manager -> gcp "Uses"
        vm_manager -> tencent_cloud "Uses"
        vm_manager -> oracle_cloud "Uses"
        vm_manager -> pie_cloud_database "Stores data in"
        vm_manager -> rabbit_mq "Sends messages to"
        vm_manager -> garnet "Caches data in"
        rabbit_mq -> vm_manager "Receives messages from"

        legacy_connector -> sentry_io "Sends observability data to"
        legacy_connector -> pie_database "Stores data in"
        legacy_connector -> pie_cloud_database "Stores data in"
        legacy_connector -> rabbit_mq "Sends messages to"
        legacy_connector -> garnet "Caches data in"
        rabbit_mq -> legacy_connector "Receives messages from"

        pie_tracker -> sentry_io "Sends observability data to"
        pie_tracker -> pie_database "Stores data in"
        pie_tracker -> pie_cloud_database "Stores data in"
        pie_tracker -> rabbit_mq "Sends messages to"
        pie_tracker -> garnet "Caches data in"
        rabbit_mq -> pie_tracker "Receives messages from"
        pie_tracker -> kafka "Streams messages to"
        kafka ->  pie_tracker "Receives streams from"

        network_boot -> sentry_io "Sends observability data to"
        network_boot -> pie_database "Stores data in"
        network_boot -> rabbit_mq "Sends messages to"
        network_boot -> garnet "Caches data in"
        rabbit_mq -> network_boot "Receives messages from"

        email_service -> sentry_io "Sends observability data to"
        email_service -> microsoft_365 "Sends e-mails via"
        rabbit_mq -> email_service "Receives messages from"

        pie_maker_device -> sentry_io "Sends observability data to"
        pie_maker_device -> kafka "Streams messages to"
        kafka ->  pie_maker_device "Receives streams from"

        rabbit_mq -> observability_user "Sends observability data to"

        opensearch_dashboard -> opensearch "Displays data from"

        production = deploymentEnvironment "Production" {
            deploymentNode "Pie Data Centre: Private Cloud" {
                deploymentNode "Bare Metal Machines" {
                    containerInstance firewall
                }

                deploymentNode "Kubernetes" {
                    containerInstance vm_manager
                    containerInstance legacy_connector
                    containerInstance pie_tracker
                }

                deploymentNode "Docker Swarm" {
                    containerInstance legacy_microservices
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
                    infrastructureNode "DB Proxy"

                    containerInstance customer_database
                    containerInstance pie_database
                    containerInstance pie_cloud_database
                }

                deploymentNode "OpenSearch Cluster" {
                    containerInstance opensearch
                    containerInstance opensearch_dashboard
                }

                deploymentNode "Garent Cluster" {
                    containerInstance garnet
                }

                deploymentNode "RabbitMQ Cluster" {
                    containerInstance rabbit_mq
                }
                
                deploymentNode "Kafka Cluster" {
                    containerInstance kafka
                }
                
                deploymentNode "ClickHouse Cluster" {
                    containerInstance clickhouse
                }
                
                deploymentNode "Private Cloud" {
                    deploymentNode "Bare Metal Machine"{
                        containerInstance pie_maker_device
                    }

                    deploymentNode "VMWare ESXi" {
                        deploymentNode "VMs"{
                            containerInstance pie_maker_device
                        }
                    }
                }
            }

            deploymentNode "Pubic Cloud" {
                deploymentNode "Azure" {
                    deploymentNode "Azure VMs"  {
                        containerInstance pie_maker_device
                    }
                }

                deploymentNode "Amazon Web Services" {
                    deploymentNode "AWS EC2" {
                        containerInstance pie_maker_device
                    }
                }

                deploymentNode "Google Cloud Platform" {
                    deploymentNode "GCP VMs" {
                        containerInstance pie_maker_device
                    }
                }

                deploymentNode "Tencet Cloud Platform" {
                    deploymentNode "Tencent Cloud VMs" {
                        containerInstance pie_maker_device
                    }
                }

                deploymentNode "Oracle Cloud" {    
                    deploymentNode "Oracle Cloud VMs" {
                        containerInstance pie_maker_device
                    }
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
            
            element "microservice" {
                background #acfb00
                color #000000
                shape Component
            }
        }
    }
}