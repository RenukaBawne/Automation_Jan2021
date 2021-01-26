*** Settings ***
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections
Library  os

*** Variables ***
${Base_URL}  http://jsonplaceholder.typicode.com
${Id}  1
${Post_Id}  2

*** Keywords ***
Response_log
    [Arguments]  ${response}
    log to console  ${response.content}
    log to console  ${response.status_code}
    log to console  ${response.headers}
    log to console  ${response.cookies}

Response_log_TC001
    [Arguments]  ${response}
    ${response}=  get on session  GetSession  /posts/
    Response_log  ${response}

Response_log_TC002
    [Arguments]  ${response}
    ${response}=  get on session  GetSession  /posts/${Id}
    Response_log  ${response}

Response_log_TC003
    [Arguments]  ${response}
    ${response}=  get on session  GetSession  /posts/${Post_Id}/comments
    Response_log  ${response}

Response_log_TC004
    [Arguments]  ${response}  ${param}
    ${response}=  get on session  GetSession   /comments  params=${param}
    Response_log  ${response}

Validate_Header
    [Arguments]  ${response}
    ${header_from_response}=  get from dictionary  ${response.headers}  Content-Type
    should contain  ${header_from_response}  application/json
    log to console  The Header contains Content-Type as applicarion/json.

Validate_Cookies
    [Arguments]  ${response}
    ${cookie_value}=  get from dictionary  ${response.cookies}  __cfduid
    log to console  The cookie value is: ${cookie_value}

Validate_StatusCode
    [Arguments]  ${response}
    ${status_code_string}=  convert to string  ${response.status_code}
    should be equal  ${status_code_string}  200
    log to console  The status code is verified.

Validate_ResponseContents
    [Arguments]  ${response}
    ${res_body}=  convert to string  ${response.content}
    should contain  ${res_body}  userId
    should contain  ${res_body}  id
    should contain  ${res_body}  title
    should contain  ${res_body}  body
    log to console  Validation is done for the keys in Response.

Validate_ResponseContents_Comments
    [Arguments]  ${response}
    ${res_body}=  convert to string  ${response.content}
    should contain  ${res_body}  postId
    should contain  ${res_body}  id
    should contain  ${res_body}  name
    should contain  ${res_body}  email
    should contain  ${res_body}  body
    log to console  Validation is done for the keys in Response.

Get_Length_for_json
    [Arguments]  ${response}
    ${json}=  Convert String to JSON  ${response.content}
    log to console  ${json}
    @{Id_list}=  Get Value From Json  ${json}  $[?(@.id)].id
    log to console  ${Id_list}
    ${length}=  get length  ${Id_list}
    log to console  The length of the json as per id is : ${length}


