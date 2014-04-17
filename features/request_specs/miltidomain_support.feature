Feature: mutidomain support

  to deploy statically on other domain and be able to send API requests
  you shouldturn off Access-Control-Allow-Origin restriction
  in config/application.rb (Rails 4)

  ```ruby
  config.action_dispatch.default_headers = {
    'Access-Control-Allow-Origin' => '<YOUR STATIC SERVER>',
    'Access-Control-Request-Method' => '*'
  }
  ```

  @wip
  Scenario: json schema gets generated into html preview using "users/destroy"
    Given a file named "lurker/api/v1/users/__id-DELETE.json.yml" with:
      """yml
      ---
      prefix: users management
      description: user deletion
      requestParameters:
        properties:
          id:
            description: ''
            type: integer
            example: 1
        required: []
      responseCodes:
      - status: 200
        successful: true
        description: ''
      responseParameters:
        properties: {}
      extensions:
        method: DELETE
        path_info: "/api/v1/users/1"
        path_params:
          action: destroy
          controller: api/v1/users
        suffix: ''
      """

  When I successfully run `bin/lurker convert`
  Then the output should contain these lines:
    """
            Converting lurker to html
     using  lurker

    create  index.html
    create  api/v1/users/__id-DELETE.html
    """

  When I go to "/lurker"
  Then I should see "users management"

  When I click on "users management"
  Then I should see "user deletion"

  When I click on "user deletion"
   And I submit lurk form

  Then I should see JSON response with "201"