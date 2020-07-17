import sys
import vim
from ..util.drawUtil import DrawUtil


def JiraVimBoardOpen(sessionStorage, isSplit: bool = True) -> None:
    """
    Open Jira Board
    """
    boardName = str(sys.argv[0])

    buf, _ = sessionStorage.getBuff(objName=boardName)

    vim.command(("sbuffer" if isSplit else "buffer") + str(buf.number))
    vim.command("setlocal modifiable")

    board = sessionStorage.getBoard(buf.number, boardName=boardName)
    DrawUtil.draw_header(buf, board, boardName)
    DrawUtil.draw_items(buf, board, sessionStorage)
    DrawUtil.set_filetype(board)
    vim.command("setlocal nomodifiable")
