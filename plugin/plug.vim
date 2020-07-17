" boards
command! -nargs=1 JiraVimBoardOpen call jira#JiraVimBoardOpen(<q-args>)
command! -nargs=1 JiraVimBoardOpenNosp call jira#JiraVimBoardOpenNoSp(<q-args>)

" issues
command! -nargs=1 JiraVimIssueOpen call board#JiraVimIssueOpen(<q-args>)
command! -nargs=1 JiraVimIssueOpenSp call board#JiraVimIssueOpenSp(<q-args>)

" utils
command! JiraVimLoadMore call jira#JiraVimLoadMore()
command! JiraVimReturn call jira#JiraVimReturn()

" search
command! -nargs=1 JiraVimSearchOpen call jira#JiraVimSearch(<q-args>)
command! -nargs=1 JiraVimSearchPriorityUnassigned call jira#JiraVimSearch("assignee is empty and priority >= " . <q-args> . " order by priority desc")
command! JiraVimSearchAssigned call jira#JiraVimSearch("assignee=currentUser()")

" select issues
command! -nargs=1 -complete=command JiraVimSelectIssue call jira#JiraVimSelectIssue(<q-args>)
command! JiraVimSelectIssueNosp call jira#JiraVimSelectIssue("JiraVimIssueOpen")
command! JiraVimSelectIssueSp call jira#JiraVimSelectIssue("JiraVimIssueOpenSp")

" select sprint
command! JiraVimSelectSprint call jira#JiraVimSelectSprint()
command! -nargs=1 JiraVimSprintOpen call jira#JiraVimSprintOpen(<q-args>)
