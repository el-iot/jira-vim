function! jira#JiraVimBoardOpen(name)
    let l:name = JiraVimTrimHelper(a:name)
    echo "Loading board " . l:name
    call check#CheckStorageSession()

    execute "python3 sys.argv = [\"" . l:name . "\"]"
    execute "python3 python.boards.open.JiraVimBoardOpen(sessionStorage)"
endfunction

function! jira#JiraVimBoardOpenNoSp(name)
    let l:name = JiraVimTrimHelper(a:name)
    echo "Loading board " . l:name
    call check#CheckStorageSession()

    execute "python3 sys.argv = [\"" . l:name . "\"]"
    execute "python3 python.boards.open.JiraVimBoardOpen(sessionStorage, False)"
endfunction

function! jira#JiraVimIssueOpen(name)
    let l:name = JiraVimTrimHelper(a:name)
    echom "Loading issue " . l:name
    call check#CheckStorageSession()

    execute "python3 sys.argv = [\"" . l:name . "\"]"
    execute "python3 python.issues.open.JiraVimIssueOpen(sessionStorage)"
endfunction

function! jira#JiraVimIssueOpenSp(name)
    let l:name = JiraVimTrimHelper(a:name)
    echom "Loading issue " . l:name
    call check#CheckStorageSession()

    execute "python3 sys.argv = [\"" . l:name . "\"]"
    execute "python3 python.issues.open.JiraVimIssueOpen(sessionStorage, True)"
endfunction

function! jira#JiraVimLoadMore()
    call check#CheckStorageSession()

    let l:moreline = line(".")

    silent execute 'normal! ?\v^-+$' . "\<cr>"
    normal! k
    let l:categoryName = matchstr(getline("."), '\v^(\u+\s?)+')
    let l:first_issue_line = line(".") + 2

    " Move the cursor back to the more line
    execute ":" . l:moreline

    execute "python3 sys.argv = [\"" . l:categoryName . "\", " . l:moreline . "]"
    if &filetype ==# "jirasprintview"
        execute "python3 python.sprints.more.JiraVimLoadMore(sessionStorage)"
    elseif &filetype ==# "jiraboardview" || &filetype ==# "jirakanbanboardview"
        execute "python3 python.boards.more.JiraVimLoadMore(sessionStorage)"
    elseif &filetype ==# "jirasearchview"
        execute "python3 python.search.more.JiraVimLoadMore(sessionStorage)"
    else
        throw "Not a valid target for loading more issues"
    endif
endfunction

function! jira#JiraVimReturn()
    """
    " This Function is designed to switch to the window with the board buffer
    " loaded. If no window like that exists, it loads the buffer in the
    " current window.
    """
    set modifiable
    if exists("b:boardBufferNumber") && b:boardBufferNumber !=? ""
        let l:bufferWindow = bufwinnr(b:boardBufferNumber)
        if l:bufferWindow !=? -1
            execute l:bufferWindow "wincmd w"
        else
            execute "buffer " . b:boardBufferNumber
        endif
    else
        throw "Could not identify the return board buffer. Are you sure you are supposed to be calling this?"
    endif
endfunction

function! jira#JiraVimSearch(query)
    let l:query = JiraVimTrimHelper(a:query)
    echom "Searching the query ..."
    call check#CheckStorageSession()

    execute "python3 sys.argv = [\"" . l:query . "\"]"
    execute "python3 python.search.open.JiraVimSearchOpen(sessionStorage)"
endfunction

function! jira#JiraVimSelectIssue(command)
    let l:command = JiraVimTrimHelper(a:command)
    call check#CheckStorageSession()
    if -1 !=# matchstr(&filetype, g:jiraBoardFiletypePattern)
        let l:bufferNumber = bufnr("%")
        let l:line = getline(line("."))
        let l:issueMatch = JiraVimTrimHelper(matchstr(l:line, '\v\u+-\d+\s'))
        if l:issueMatch != ""
            execute l:command " " l:issueMatch
            let b:boardBufferNumber = l:bufferNumber
        endif
    else
        throw "The current buffer is not a board, are you sure you should be calling this command?"
    endif
endfunction

function! jira#JiraVimSelectSprint()
    let l:sprintName = JiraVimTrimHelper(getline(line(".")))
    execute "JiraVimSprintOpen " l:sprintName
endfunction

function! jira#JiraVimSprintOpen(name)
    let l:name = JiraVimTrimHelper(a:name)
    echo "Loading sprint " . l:name
    call check#CheckStorageSession()

    execute "python3 sys.argv = [\"" . l:name . "\"]"
    execute "python3 python.sprints.open.JiraVimSprintOpen(sessionStorage, False)"
endfunction

