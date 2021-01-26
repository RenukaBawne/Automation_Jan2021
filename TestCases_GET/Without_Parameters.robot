*** Settings ***
Resource    ../Resources/Resources.robot
Force Tags  APIValidation

*** Test Cases ***
TC_001_Get_Request_Without_Parameters
    [Documentation]  This test case will validate the Get Respons for the url /posts
    create session  GetSession  ${Base_URL}
    ${response}=  get on session  GetSession  /posts

    Response_log_TC001  ${response}

    #Validating the Status code
    Validate_StatusCode  ${response}

    #Validating the Header
    Validate_Header  ${response}

    #Validating the cookies
    Validate_Cookies  ${response}

    #Validating the Contents by fetching json object and validating the keys userId,id,title,body
    Validate_ResponseContents  ${response}

    ${json}=  Convert String to JSON  ${response.content}
    log to console  ${json}
    @{Id_list}=  Get Value From Json  ${json}  $[?(@.id)].id
    log to console  ${Id_list}
    ${length}=  get length  ${Id_list}
    log to console  The length of the json,counting by id is : ${length}

    # For loop for checking the keys
    FOR    ${i}    IN    ${length}
        ${res_body}=  convert to string  ${response.content}
        should contain  ${res_body}  userId
        should contain  ${res_body}  id
        should contain  ${res_body}  title
        should contain  ${res_body}  body
        log to console  Validation is done for the keys in Response.
    END
    log to console  Validation is done for GET API.




