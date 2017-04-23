require "spec_helper"
require "loaders/ticket_json_loader"

RSpec.describe TicketJsonLoader do

  json = <<-JSON
    [
      {
        "_id": "436bf9b0-1147-4c0a-8439-6f79833bff5b",
        "url": "http://initech.zendesk.com/api/v2/tickets/436bf9b0-1147-4c0a-8439-6f79833bff5b.json",
        "external_id": "9210cdc9-4bee-485f-a078-35396cd74063",
        "created_at": "2016-04-28T11:19:34 -10:00",
        "type": "incident",
        "subject": "A Catastrophe in Korea (North)",
        "description": "Nostrud ad sit velit cupidatat laboris ipsum nisi amet laboris ex exercitation amet et proident. Ipsum fugiat aute dolore tempor nostrud velit ipsum.",
        "priority": "high",
        "status": "pending",
        "submitter_id": 38,
        "assignee_id": 24,
        "organization_id": 116,
        "tags": [
          "Ohio",
          "Pennsylvania",
          "American Samoa",
          "Northern Mariana Islands"
        ],
        "has_incidents": false,
        "due_at": "2016-07-31T02:37:50 -10:00",
        "via": "web"
      }
    ]
  JSON

  expected_attributes = {
    "_id" => "436bf9b0-1147-4c0a-8439-6f79833bff5b",
    "url" => "http://initech.zendesk.com/api/v2/tickets/436bf9b0-1147-4c0a-8439-6f79833bff5b.json",
    "external_id" => "9210cdc9-4bee-485f-a078-35396cd74063",
    "created_at" => "2016-04-28T11:19:34 -10:00",
    "type" => "incident",
    "subject" => "A Catastrophe in Korea (North)",
    "description" => "Nostrud ad sit velit cupidatat laboris ipsum nisi amet laboris ex exercitation amet et proident. Ipsum fugiat aute dolore tempor nostrud velit ipsum.",
    "priority" => "high",
    "status" => "pending",
    "submitter_id" => 38,
    "assignee_id" => 24,
    "organization_id" => 116,
    "tags" => [
      "Ohio",
      "Pennsylvania",
      "American Samoa",
      "Northern Mariana Islands"
    ],
    "has_incidents" => false,
    "due_at" => "2016-07-31T02:37:50 -10:00",
    "via" => "web"
  }

  it_behaves_like "a json_loadable object", Ticket, json, expected_attributes

end
