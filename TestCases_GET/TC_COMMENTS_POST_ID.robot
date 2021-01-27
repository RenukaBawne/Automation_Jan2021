*** Settings ***
Resource    ../Resources/Resources.robot
Force Tags  APIValidation

*** Test Cases ***
TC_13_Validate_Headers
    [Documentation]  This test case will validate the header in Get Response for the url /comments?postId=${Post_Id}
    create session  GetSession  ${Base_URL}
    &{param}  create dictionary  postId=${Post_Id}
    ${response}=  get on session  GetSession  /comments  params=${param}
    Validate_Headers  ${response}

TC_14_Validate_Status_Code
    [Documentation]  This test case will validate the Status_code in Get Response for the url /comments?postId=${Post_Id}
    create session  GetSession  ${Base_URL}
    &{param}  create dictionary  postId=${Post_Id}
    ${response}=  get on session  GetSession  /comments  params=${param}
    Validate_StatusCode  ${response}

TC_15_Validate_Cookies
    [Documentation]  This test case will validate the Cookie in Get Response for the url /comments?postId=${Post_Id}
    create session  GetSession  ${Base_URL}
    &{param}  create dictionary  postId=${Post_Id}
    ${response}=  get on session  GetSession  /comments  params=${param}
    Validate_Cookies  ${response}

TC_16_Validate_Response
    [Documentation]  This test case will validate the Response for the url /comments?postId=${Post_Id}
    create session  GetSession  ${Base_URL}
    &{param}  create dictionary  postId=${Post_Id}
    ${response}=  get on session  GetSession  /comments  params=${param}
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
        ${get_postId} =  Set variable    ${item['postId']}
        ${get_id} =  Set variable    ${item['id']}
        ${get_name} =  Set variable    ${item['name']}
        ${get_email} =  Set variable    ${item['email']}
        ${get_body} =    Set variable    ${item['body']}
        log to console   ${get_postId} | ${get_id} | ${get_name} | ${get_email} | ${get_body}
        run keyword if  "${get_postId}"=="${EMPTY}"    log to console   Warning : Post ID is Empty
        run keyword if  "${get_id}"=="${EMPTY}"    log to console   Warning : ID is Empty
        run keyword if  "${get_name}"=="${EMPTY}"    log to console   Warning : Title is Empty
        run keyword if  "${get_email}"=="${EMPTY}"    log to console   Warning : User ID is Empty

        log to console  Validation is done for the keys in Response.
    END
    log to console  Validation is done for GET API.


