*** Settings ***
Resource    ../Resources/Resources.robot
Force Tags  APIValidation

*** Test Cases ***
TC_01_Validate_Headers
    [Documentation]  This test case will validate the Header in Get Response for the url /posts
    create session  GetSession  ${Base_URL}
    ${response}=  get on session  GetSession  /posts
    Validate_Headers  ${response}

TC_02_Validate_Status_Code
    [Documentation]  This test case will validate the Status_code in Get Response for the url /posts
    create session  GetSession  ${Base_URL}
    ${response}=  get on session  GetSession  /posts
    Validate_StatusCode  ${response}

TC_03_Validate_Cookies
    [Documentation]  This test case will validate the Cookie in Get Response for the url /posts
    create session  GetSession  ${Base_URL}
    ${response}=  get on session  GetSession  /posts
    Validate_Cookies  ${response}

TC_04_Validate_Response
    [Documentation]  This test case will validate the keys in Get Response for the url /posts
    create session  GetSession  ${Base_URL}
    ${response}=  get on session  GetSession  /posts
    Response_log  ${response}
    ${json}=  Convert String to JSON  ${response.content}
    log to console  ${json}
    @{Id_list}=  Get Value From Json  ${json}  $[?(@.id)].id
    log to console  ${Id_list}
    ${length}=  get length  ${Id_list}
    log to console  The length of the json,counting by id is : ${length}

    #For loop for checking the keys
    FOR    ${item}  IN  @{json}
        log to console  to console  Value of item is : ${item}
        ${get_userId} =  Set variable    ${item['userId']}
        ${get_id} =  Set variable    ${item['id']}
        ${get_title} =  Set variable    ${item['title']}
        ${get_body} =    Set variable    ${item['body']}
        log to console   ${get_userId} | ${get_id} | ${get_title} | ${get_body}
        run keyword if  "${get_title}"=="${EMPTY}"    log to console   Warning : Title is Empty
        run keyword if  "${get_userId}"=="${EMPTY}"    log to console   Warning : User ID is Empty
        run keyword if  "${get_id}"=="${EMPTY}"    log to console   Warning : ID is Empty
        log to console  Validation is done for the keys in Response.
    END
    log to console  Validation is done for GET API.


