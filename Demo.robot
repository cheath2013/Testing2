** Settings **
Library    OperatingSystem

*** Test Cases ***
Create Folder
    [Tags]    Creation
    [Documentation]    Create a directory named 'myDir'
    Create Directory    myDir

Confirm Folder
    [Tags]    Creation
    [Documentation]    Make sure Directory Exists named 'myDir'
    Directory Should Exist    myDir

Create File
    [Tags]    Creation
    [Documentation]    Create a File in 'myDir' named 'newFile.txt'
    Create File    ${CURDIR}/myDir/newFile.txt

Confirm File
    [Tags]    Creation
    [Documentation]    Make sure File Exists named 'newFile.txt'
    File Should Exist    ${CURDIR}/myDir/newFile.txt

Add Content
    [Tags]    Creation
    [Documentation]    Add a message using a variable to 'newFile.txt'
    Append To File    ${CURDIR}/myDir/newFile.txt    ${MESSAGE}

Confirm Content
    [Tags]    Creation
    [Documentation]    Confirm message was added to 'newFile.txt'
    Grep File    ${CURDIR}/myDir/newFile.txt    ${MESSAGE}


Full Test
    [Documentation]    Complete the entire Test using keyword 'Creation Test' keyword
    [Tags]    Creation, Combine Tests
    Creation Test

Full Test (Remove)
    Removal Test

*** comment ***
Fail Test
    [Documentation]    Test to show failing results.
    [Tags]    Failure

    Failing Test 2

* Keywords *
Creation Test
    Create Directory    myDir
    Directory Should Exist    myDir
    Create File    ${CURDIR}/myDir/newFile.txt
    File Should Exist    ${CURDIR}/myDir/newFile.txt
    Append To File    ${CURDIR}/myDir/newFile.txt    ${MESSAGE}
    Grep File    ${CURDIR}/myDir/newFile.txt    ${MESSAGE}

Removal Test
    Remove File    ${CURDIR}/myDir/newFile.txt
    File Should Not Exist    myDir
    Remove Directory    myDir
    Directory Should Not Exist    myDir

Failing Test 1
    File Should Exist   NonExistantFile.lie


Failing Test 2
    Directory Should Be Empty    ${CURDIR}




**** Variable ****
${MESSAGE}=    Hello, World!
