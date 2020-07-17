" boards
command! -nargs=1 JiraBoardOpen call jira#JiraVimBoardOpen(<q-args>)
command! -nargs=1 JiraBoardOpenNosp call jira#JiraVimBoardOpenNoSp(<q-args>)

" issues
command! -nargs=1 JiraIssueOpen call board#JiraVimIssueOpen(<q-args>)
command! -nargs=1 JiraIssueOpenSp call board#JiraVimIssueOpenSp(<q-args>)

" utils
command! JiraLoadMore call jira#JiraVimLoadMore()
command! JiraReturn call jira#JiraVimReturn()

" search
command! -nargs=1 JiraSearchOpen call jira#JiraVimSearch(<q-args>)
command! -nargs=1 JiraSearchPriorityUnassigned call jira#JiraVimSearch("assignee is empty and priority >= " . <q-args> . " order by priority desc")
command! JiraSearchAssigned call jira#JiraVimSearch("assignee=currentUser()")

" select issues
command! -nargs=1 -complete=command JiraSelectIssue call jira#JiraVimSelectIssue(<q-args>)
command! JiraSelectIssueNosp call jira#JiraVimSelectIssue("JiraVimIssueOpen")
command! JiraSelectIssueSp call jira#JiraVimSelectIssue("JiraVimIssueOpenSp")

" select sprint
command! JiraSelectSprint call jira#JiraVimSelectSprint()
command! -nargs=1 JiraSprintOpen call jira#JiraVimSprintOpen(<q-args>)
