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

Validate_Headers
    [Arguments]  ${response}
    ${header_from_response}=  get from dictionary  ${response.headers}  Content-Type
    should be equal  ${header_from_response}  application/json; charset=utf-8
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


