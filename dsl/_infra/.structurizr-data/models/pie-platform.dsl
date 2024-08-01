# Software Systems
pie_platform = softwareSystem "Pie Platform" "A platform for building, managing and monitoring Pie production." {
    !docs docs/pie-platform/
    !adrs adrs/pie-platform/
    
    # Networking services
    firewall = container "Firewall" "Firewall solution." "Go" {
        !docs docs/firewall/
        !adrs adrs/firewall/
    }

    # Application services
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
    group "Customer Device" {
        mobile_app = container "Mobile App" "The mobile application for the Pie Platform." "React Native" "mobile_app"
    }
    
    # Data stores
    customer_database = container "Customer Database" "The database for customer information." "FoxPro" "Database"
    pie_database = container "Pies Database" "The database for internally build Pies." "SQL Server" "Database"
    pie_cloud_database = container "Pie Cloud Database" "The database for Pies built and managed in external cloud services." "MongoDB" "Database"
    
    opensearch = container "OpenSearch" "The search engine for the Pie Platform." "opensearch" "Database"
    opensearch_dashboard = container "OpenSearch Dashboard" "A dashboard built to integrate with OpenSearch." "opensearch" "Telemetry"

    garnet = container "Garnet" "The distributed cache for the Pie Platform." "Garent" "Database"

    rabbit_mq = container "Rabbit MQ" "The message broker for the Pie Platform." "rabbit_mq" "Messaging"
    kafka = container "Kafka" "The data streaming service for the Pie Platform." "kafka" "Messaging"            
    clickhouse = container "ClickHouse" "Configuration and messaing sysem." "ClickHouse" "Messaging"
}
