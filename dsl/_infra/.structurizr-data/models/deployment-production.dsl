production = deploymentEnvironment "Production" {
    deploymentNode "Pie Data Centre: Private Cloud" {

        deploymentNode "Firewall Cluster" {
            deploymentNode "Firewall Nodes" {
                instances 4

                containerInstance firewall 
            }
        }

        deploymentNode "Kubernetes Cluster" {
            deploymentNode "Kubernetes Master" {
                instances 2

                infrastructureNode "Kubernetes Master"
            }

            deploymentNode "Kubernetes Node" {
                instances 16

                containerInstance vm_manager
                containerInstance legacy_connector
                containerInstance pie_tracker
            }
        }

        deploymentNode "Docker Swarm" {
            deploymentNode "Docker Node" {
                instances 16

                containerInstance legacy_microservices
                containerInstance network_boot
            }
        }

        deploymentNode "Cron Jobs" {
            containerInstance all_cron_jobs
        }

        deploymentNode "API Gateway" {
            instances 4

            containerInstance api_gateway
        }

        deploymentNode "Web Servers" {
            deploymentNode "Web Server Node" {
                instances 3

                containerInstance api
                containerInstance customer_portal
                containerInstance admin_portal
            }
        }

        deploymentNode "Database Cluster" {
            deploymentNode "Proxy Units" {
                instances 2
                description "Proxy units for the database cluster."

                infrastructureNode "DB Proxy"
            }

            deploymentNode "Replication Node" {
                instances 3

                containerInstance customer_database
                containerInstance pie_database
                containerInstance pie_cloud_database
            }
        }

        deploymentNode "OpenSearch Cluster" {
            deploymentNode "OpenSearch Node" {
                instances 6

                containerInstance opensearch
            }

            deploymentNode "OpenSearch Search Node" {
                instances 2

                containerInstance opensearch
            }

            deploymentNode "OpenSearch Dashboard Node" {
                instances 2

                containerInstance opensearch_dashboard
            }
        }

        deploymentNode "Garent Cluster" {
            deploymentNode "Garent Node" {
                instances 6
                
                containerInstance garnet
            }
        }

        deploymentNode "RabbitMQ Cluster" {
            deploymentNode "RabbitMQ Node" {
                instances 8

                containerInstance rabbit_mq
            }
        }
        
        deploymentNode "Kafka Cluster" {
            deploymentNode "Kafka Node" {
                instances 3

                containerInstance kafka
            }
        }
        
        deploymentNode "ClickHouse Cluster" {
            deploymentNode "ClickHouse Node" {
                instances 6

                containerInstance clickhouse
            }
        }
        
        deploymentNode "Private Cloud" {
            deploymentNode "Bare Metal Machine"{
                containerInstance pie_maker_device
            }

            deploymentNode "VMWare ESXi" {
                deploymentNode "VMs" {
                    containerInstance pie_maker_device
                }
            }
        }
    }

    deploymentNode "Pubic Cloud" {
        deploymentNode "Azure" {
            deploymentNode "Azure VMs" {
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