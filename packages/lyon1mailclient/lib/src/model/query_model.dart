Map<String, dynamic> makeQuerry(String query) {
  return {
    "__type": "FindPeopleJsonRequest:#Exchange",
    "Header": {
      "__type": "JsonRequestHeaders:#Exchange",
      "RequestServerVersion": "Exchange2013",
      "TimeZoneContext": {
        "__type": "TimeZoneContext:#Exchange",
        "TimeZoneDefinition": {
          "__type": "TimeZoneDefinitionType:#Exchange",
          "Id": "Romance Standard Time"
        }
      }
    },
    "Body": {
      "__type": "FindPeopleRequest:#Exchange",
      "IndexedPageItemView": {
        "__type": "IndexedPageView:#Exchange",
        "BasePoint": "Beginning",
        "Offset": 0
      },
      "QueryString": query,
      "AggregationRestriction": {
        "__type": "RestrictionType:#Exchange",
        "Item": {
          "__type": "Or:#Exchange",
          "Items": [
            {
              "__type": "Exists:#Exchange",
              "Item": {
                "__type": "PropertyUri:#Exchange",
                "FieldURI": "PersonaEmailAddress"
              }
            },
            {
              "__type": "IsEqualTo:#Exchange",
              "Item": {
                "__type": "PropertyUri:#Exchange",
                "FieldURI": "PersonaType"
              },
              "FieldURIOrConstant": {
                "__type": "FieldURIOrConstantType:#Exchange",
                "Item": {
                  "__type": "Constant:#Exchange",
                  "Value": "DistributionList"
                }
              }
            }
          ]
        }
      },
      "PersonaShape": {
        "__type": "PersonaResponseShape:#Exchange",
        "BaseShape": "Default",
        "AdditionalProperties": [
          {"__type": "PropertyUri:#Exchange", "FieldURI": "PersonaAttributions"}
        ]
      },
      "ShouldResolveOneOffEmailAddress": true,
      "SearchPeopleSuggestionIndex": false,
      "Context": [
        {
          "__type": "ContextProperty:#Exchange",
          "Key": "AppName",
          "Value": "OWA"
        },
        {
          "__type": "ContextProperty:#Exchange",
          "Key": "AppScenario",
          "Value": "NewMail.To"
        },
        {
          "__type": "ContextProperty:#Exchange",
          "Key": "ClientSessionId",
          "Value": ""
        }
      ]
    }
  };
}
