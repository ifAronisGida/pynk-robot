*** Settings ***
Documentation     Template robot main suite.
Library           RPA.Browser.Selenium    auto_close=${FALSE}
Library           Utils.py
Library           RPA.Desktop
Library           RPA.Robocorp.Vault

*** Tasks ***
Daily predict
    Login to pynk
    Do daily predict

*** Keywords ***
Login to pynk
    ${secret}=    Get Secret    pynk_login
    Open Available Browser    https://beta.pynk.io/login
    Input Text    email    ${secret}[user]
    Input Password    password    ${secret}[password]
    Click Button    submit
    Wait Until Page Contains Element    css:div.btn-remind-me-later    10
    Sleep    2s
    Click Element    css:div.btn-remind-me-later
    Wait Until Page Contains Element    css:div.btn-continue-on-browser    10
    Sleep    2s
    Click Element    css:div.btn-continue-on-browser

Do daily predict
    Go To    https://beta.pynk.io/prediction
    Wait Until Page Contains Element    id:prediction_price
    FOR    ${counter}    IN RANGE    5
        Log To Console    \nPredict #${counter} started..
        Sleep    2s
        Click Element When Visible    css:div.item.next
        Sleep    2s
        Click Element When Visible    css:div.item.next
        FOR    ${inner_counter}    IN RANGE    ${counter}
            Log To Console    \nClicking next #${inner_counter}..
            Sleep    2s
            Click Element When Visible    css:div.item.next
        END
        Enter predict
    END

Enter predict
    Log To Console    \nEnter predict started..
    Sleep    2s
    ${price}=    Get Text    css:span.price
    ${current_price}=    Parse Price    ${price}
    ${random_price}=    Randomize Price    ${current_price}
    Input Text    id:prediction_price    ${random_price}
    Log To Console    \nFirst predict typed in: ${random_price}
    Sleep    9s
    Click Button    sumbit
    Sleep    2s
    Click Element    css:ul.stake-list > li:nth-child(2)
    Click Element    id:next
    Sleep    2s
    ${crowd_average_price}=    Average Price    ${current_price}    ${random_price}
    Input Text    id:crowd_average_price    ${crowd_average_price}
    Log To Console    \nCrowd average typed in: ${crowd_average_price}
    Click Element When Visible    link:Next
    Click Element When Visible    link:Show crowd average
    Click Element When Visible    link:Stick
    Sleep    2s
    Log To Console    \nFinished predict, navigating to /prediction..
    Go To    https://beta.pynk.io/prediction
    Sleep    2s
