require "spec_helper"
require "loaders/organization_json_loader"

RSpec.describe OrganizationJsonLoader do

  json = <<-JSON
    [
      {
        "_id": 101,
        "url": "http://initech.zendesk.com/api/v2/organizations/101.json",
        "external_id": "9270ed79-35eb-4a38-a46f-35725197ea8d",
        "name": "Enthaze",
        "domain_names": [
          "kage.com",
          "ecratic.com",
          "endipin.com",
          "zentix.com"
        ],
        "created_at": "2016-05-21T11:10:28 -10:00",
        "details": "MegaCorp",
        "shared_tickets": false,
        "tags": [
          "Fulton",
          "West",
          "Rodriguez",
          "Farley"
        ]
      }
    ]
  JSON

  expected_attributes = {
    "id" => 101,
    "url" => "http://initech.zendesk.com/api/v2/organizations/101.json",
    "external_id" => "9270ed79-35eb-4a38-a46f-35725197ea8d",
    "name" => "Enthaze",
    "domain_names" => [
      "kage.com",
      "ecratic.com",
      "endipin.com",
      "zentix.com"
    ],
    "created_at" => "2016-05-21T11:10:28 -10:00",
    "details" => "MegaCorp",
    "shared_tickets" => false,
    "tags" => [
      "Fulton",
      "West",
      "Rodriguez",
      "Farley"
    ]
  }

  it_behaves_like "a json_loadable object", Organization, json, expected_attributes

end
