workspace "Pie Platform" "A platform for building, managing and monitoring Pie production." {
    model {
        !include models/properties.dsl
        !include models/users.dsl
        !include models/pie-platform.dsl
        !include models/external-services.dsl
        !include models/relationships.dsl

        # Deployments
        !include models/deployment-production.dsl 
    }

    !include models/views.dsl
}