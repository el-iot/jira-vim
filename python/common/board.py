
from ..util.itemExtractor import ItemExtractor

class Board:
    def __init__(self, boardId, boardName, connection):
        self.connection = connection
        self.id = boardId
        self.boardName = boardName
        self.baseUrl = "/rest/agile/1.0/board/"+boardId
        self.requiredProperties = ["key", "status", "summary"]

        self.boardConf = self.connection.customRequest(self.baseUrl+"/configuration").json()
        self.statusToColumn = {}
        self.columns = list()

        """
        The idea here is that each column can display many statuses. So the relationship from status to column is many to one. Then each instance sorts issues into columns on its own.
        """
        col_set = set()
        for col in self.boardConf["columnConfig"]["columns"]:
            cName = col["name"]
            if cName not in col_set:
                self.columns.append(cName)
                col_set.add(cName)
            for s in col["statuses"]:
                self.statusToColumn[s["id"]] = cName

        self.issueExtractor = ItemExtractor(self.connection, self.baseUrl+"/issue?fields=%s", lambda: (','.join(self.requiredProperties),))

    def getIssues(self, column=None):
        r = self.issueExtractor.__next__()
        categoryName = "All Issues"
        return [(categoryName, self.issueExtractor.finished, [(i["key"], "") for i in r["issues"]])]
