 views {
    # System context views
    systemContext pie_platform "SystemContextDiagram" {
        include *
        autolayout
    }

    # Container views
    container pie_platform "ContainerDiagram" {
        include *
        autolayout
    }
    
    container pie_platform "MicroservicesDiagram" "Microservices with assocatied databases." {
        include "element.tag==microservice" "element.tag==Database"
        autolayout
    }

    # Deployment views
    deployment * development "DevelopmentDeployment" "The deployment of the Pie Platform in a development environment." {
        include *
        autolayout
    }

    deployment * test "TestingDeployment" "The deployment of the Pie Platform in a test environment." {
        include *
        autolayout
    }

    deployment * production "ProductionDeployment" "The deployment of the Pie Platform in a production environment." {
        include *
        autolayout
    }

    !include styles.dsl
}
