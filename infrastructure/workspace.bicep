param workspaceName string
param location string = resourceGroup().location

resource LogAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2021-12-01-preview' = {
  name: workspaceName
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 90
  }
}

resource LogAnalyticsSolution 'Microsoft.OperationsManagement/solutions@2015-11-01-preview' = {
  name: 'SecurityInsights(${LogAnalyticsWorkspace.name})'
  location:location
  properties: {
    workspaceResourceId: LogAnalyticsWorkspace.id
  }
  plan: {
    publisher: 'Microsoft'
    product: 'OMSGallery/SecurityInsights'
    name: 'SecurityInsights(${LogAnalyticsWorkspace.name})'
    promotionCode: ''
  }
}



