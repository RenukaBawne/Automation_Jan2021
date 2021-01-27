*** Settings ***
Resource    ../Resources/Resources.robot
Force Tags  APIValidation

*** Test Cases ***
TC_05_Validate_Headers
    [Documentation]  This test case will validate the Headers in Get Response for the url /posts/1
    create session  GetSession  ${Base_URL}
    ${response}=  get on session  GetSession  /posts/${Id}
    Validate_Headers  ${response}

TC_06_Validate_Status_Code
    [Documentation]  This test case will validate the Status_code in Get Response for the url /posts/1
    create session  GetSession  ${Base_URL}
    ${response}=  get on session  GetSession  /posts/${Id}
    Validate_StatusCode  ${response}

TC_07_Validate_Cookies
    [Documentation]  This test case will validate the Cookie in Get Response for the url /posts/1
    create session  GetSession  ${Base_URL}
    ${response}=  get on session  GetSession  /posts/${Id}
    Validate_Cookies  ${response}

TC_08_Validate_Response
    [Documentation]  This test case will validate the keys in Get Response for the url /posts/1
    create session  GetSession  ${Base_URL}
    ${response}=  get on session  GetSession  /posts/${Id}
    Response_log  ${response}
    ${json}=  Convert String to JSON  ${response.content}
    log to console  ${json}

    ${get_userId} =  Set variable    ${json['userId']}
    ${get_id} =  Set variable    ${json['id']}
    ${get_title} =  Set variable    ${json['title']}
    ${get_body} =    Set variable    ${json['body']}
    log to console   ${get_userId} | ${get_id} | ${get_title} | ${get_body}
    run keyword if  "${get_title}"=="${EMPTY}"    log to console   Warning : Title is Empty
    run keyword if  "${get_userId}"=="${EMPTY}"    log to console   Warning : User ID is Empty
    run keyword if  "${get_id}"=="${EMPTY}"    log to console   Warning : ID is Empty

