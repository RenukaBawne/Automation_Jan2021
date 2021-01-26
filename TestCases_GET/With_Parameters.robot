*** Settings ***
Resource    ../Resources/Resources.robot
Force Tags  APIValidation

*** Test Cases ***
TC_002_Get_Request_With_Parameters
    [Documentation]  This test case will validate the Get Respons for the url /posts/1
    create session  GetSession  ${Base_URL}
    ${response}=  get on session  GetSession  /posts/${Id}

    Response_log_TC002  ${response}

    #Validating the Status code
    Validate_StatusCode  ${response}

    #Validating the Header
    Validate_Header  ${response}

    #Validating the cookies
    Validate_Cookies  ${response}

    #Validating the Contents by fetching json object and validating the keys userId,id,title,body
    Validate_ResponseContents  ${response}

TC_003_Get_Request_With_Parameters
    [Documentation]  This takes the parameters refering to the url as /posts/${Id}/comments
    create session  GetSession  ${Base_URL}
    ${response}=  get on session  GetSession  /posts/${Post_Id}/comments

    Response_log_TC003  ${response}

    #Validating the Status code
    Validate_StatusCode  ${response}

    #Validating the Header
    Validate_Header  ${response}

    #Validating the cookies
    Validate_Cookies  ${response}

    #Validating the Contents by fetching json object and validating the keys userId,id,title,body
    Validate_ResponseContents_Comments  ${response}

    #get_length_for_json  ${response}
    ${json}=  Convert String to JSON  ${response.content}
    log to console  ${json}
    @{Id_list}=  Get Value From Json  ${json}  $[?(@.id)].id
    log to console  ${Id_list}
    ${length}=  get length  ${Id_list}
    log to console  The length of the json as per id is : ${length}

    # For loop for checking the keys
    FOR    ${i}    IN    ${length}
        validate_responsecontents_comments  ${response}
        log to console  Validation is done for the keys in Response.
    END
    log to console  Validation is done for GET API.

TC_004_Get_Request_With_Parameters
    [Tags]  Check
    [Documentation]  This takes the parameters refering to the url as /comments?postId=${Post_Id}
    create session  GetSession  ${Base_URL}
    &{param}  create dictionary  postId=${Post_Id}
    ${response}=  get on session  GetSession  /comments  params=${param}

    Response_log_TC004  ${response}  ${param}

    #Validating the Status code
    Validate_StatusCode  ${response}

    #Validating the Header
    Validate_Header  ${response}

    #Validating the cookies
    Validate_Cookies  ${response}

    #Validating the Contents by fetching json object and validating the keys userId,id,title,body
    Validate_ResponseContents_Comments  ${response}

    #get_length_for_json  ${response}
    [Arguments]  ${response}
    ${json}=  Convert String to JSON  ${response.content}
    log to console  ${json}
    @{Id_list}=  Get Value From Json  ${json}  $[?(@.id)].id
    log to console  ${Id_list}
    ${length}=  get length  ${Id_list}
    log to console  The length of the json as per id is : ${length}

    # For loop for checking the keys
    FOR    ${i}    IN    ${length}
        validate_responsecontents_comments  ${response}
        log to console  Validation is done for the keys in Response.
    END
    log to console  Validation is done for GET API.
